package tracking

import planning.BudgetItem;
import category.Category;

import assetLiability.AssetLiability
import assetLiability.AssetLiabilityClass
import grails.transaction.Transactional

/**
 * @author Anthony
 *
 */
@Transactional
class TransactionService {

    def create(Transaction transaction) {
//		addBudgetItem(transaction)
		adjustAmount(transaction,"add")
		adjustAccount(transaction)
		processAssetLiability(transaction,"add")
		processContraTransaction(transaction)
		
		transaction.save()
    }
	
	def delete(Transaction transaction){
		adjustAmount(transaction,"subtract")
		adjustAccount(transaction)
		processAssetLiability(transaction,"delete")
		def ct = Transaction.findByName("CC Procedes for ${transaction.name}")
		if(ct){
			ct.delete()
		}
		removeFromAssociations(transaction)
	}

	def edit(Transaction newTransaction, Transaction oldTransaction){
		adjustAmount(oldTransaction,"subtract")
		adjustAccount(oldTransaction)
		processAssetLiability(oldTransaction,"delete")
		def ct = Transaction.findByName("CC Procedes for ${newTransaction.name}")
		if(ct){
			ct.delete()
		}
//		removeFromAssociations(oldTransaction)
		
		if(newTransaction.combinationId){
			if(newTransaction.transactionDate != oldTransaction.transactionDate){
				adjustComboTransactionDates(newTransaction)
			}
		}
		
		adjustAmount(newTransaction,"add")
		adjustAccount(newTransaction)
		processAssetLiability(newTransaction,"add")
		processContraTransaction(newTransaction)
		if(oldTransaction.category != newTransaction.category || 
		   oldTransaction.transactionDate.format("yyyy").toInteger() != newTransaction.transactionDate.format("yyyy").toInteger() || 
		   oldTransaction.transactionDate.format("MM").toInteger() != newTransaction.transactionDate.format("MM").toInteger()){
			addBudgetItem(newTransaction)
		}
		
		oldTransaction.delete(flush:true)
		
	}

	private adjustAccount(Transaction transaction) {
		def account = transaction.account
		if(account.assetLiability){
			AssetLiability al = account.assetLiability
					al.value -= transaction.amount
		}else{
			if(transaction.category.cash == 'Y'){
				account.balance += transaction.amount
			}else{
				account = Account.get("2295".toLong())
			}
		}
	}

	private adjustAmount(Transaction transaction, String action) {
		transaction.amount = Math.abs(transaction.amount)
		if(transaction.category.type == "E"){
			transaction.amount *= -1
		}
		if(action == "subtract"){
			transaction.amount *= -1
		}
		
	}

	private addBudgetItem(Transaction transaction) {
		
		List budgetItemSearchResult = BudgetItem.withCriteria{
			eq("month",transaction.transactionDate.format("MM").toInteger())
			eq("year",transaction.transactionDate.format("yyyy").toInteger())
			category{
				eq("id",transaction.category.id)
			}
		}
		
		BudgetItem budgetItem
		if(budgetItemSearchResult){
			budgetItem = budgetItemSearchResult.get(0)
		}
		BudgetItem previousBudgetItem = transaction.budgetItem
		if(budgetItem){
			transaction.budgetItem = budgetItem
			if(budgetItem.required == "Y"){
				flagPlannnedTransactions(budgetItem)
			}
		}else{
			transaction.budgetItem = null
		}
		
//		if(previousBudgetItem != transaction.budgetItem){
//			previousBudgetItem?.removeFromTransactions(transaction)
//		}
	
	}
	
	private processAssetLiability(Transaction transaction, String task){
		Double amount 
		Category category = transaction.category
		AssetLiability assetLiability = category.assetLiability
		
		if(assetLiability){
			switch (task) {
			case "add":
				amount = Math.abs(transaction.amount)
				break;
			case "delete":
				amount = Math.abs(transaction.amount) * (-1)
				break;
			default:
				break;
			}
				
			assetLiability.value += (amount * category.assetLiabilityAction)
			transaction.assetLiability = assetLiability
			
			assetLiability.save(flush:true)
		}
	}
	
	private removeFromAssociations(Transaction transaction){
		def category = transaction.category
		category.removeFromTransactions(transaction)
		
		BudgetItem budgetItem = transaction.budgetItem
		budgetItem?.removeFromTransactions(transaction)
		if(budgetItem) flagPlannnedTransactions(budgetItem)
		
		AssetLiability assetLiability = transaction.assetLiability
		assetLiability?.removeFromTransactions(transaction)
		
		Account account = transaction.account
		account.removeFromTransactions(transaction)
	}
	
	private adjustComboTransactionDates(Transaction transaction){
		List combotransactions = Transaction.withCriteria{
			eq("combinationId",transaction.combinationId)
		}
		combotransactions.each {
			it.transactionDate = transaction.transactionDate
			it.save(flush:true)
		}
	}
	
	private flagPlannnedTransactions(BudgetItem budgetItemInstance){
		def plannedTransactions = PlannedTransaction.withCriteria {
			budgetItem{
				eq("id",budgetItemInstance.id)
			}
			order("plannedTransactionDate","asc")
		}
		def totalTransactionAmount = Transaction.withCriteria {
			budgetItem{
				eq("id",budgetItemInstance.id)
			}
			projections{
				sum("amount")
			}
		}.get(0)
		
		if(!totalTransactionAmount){
			 totalTransactionAmount = 0;
		}
		println "totalTransactionAmount ${totalTransactionAmount}"
		if (plannedTransactions){
			plannedTransactions.each {plannedTransaction->
			if(totalTransactionAmount>=plannedTransaction.amount){
				plannedTransaction.rolling = "N"
				plannedTransaction.save(flush:true)
			}
			totalTransactionAmount-=plannedTransaction.amount
			}
		}
		
	}
	
	private processContraTransaction(Transaction transaction){
		Double amount
		AssetLiabilityClass assetLiabilityClass = transaction.account.assetLiability?.assetLiabilityClass
		
		if(assetLiabilityClass == AssetLiabilityClass.findByName('CREDIT CARD')){
			def contraTransaction = new Transaction(name: "CC Procedes for ${transaction.name}",
													amount: transaction.amount * (-1),
													category: Category.findByName("${assetLiability.name}-Proceedes"),
													account: Account.findByName("NO RESOURCE"),
													relationship:'child'
													)
			transaction.relationship = 'parent'
			contraTransaction.save()
		}
	}
}
