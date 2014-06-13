package tracking

import grails.transaction.Transactional
import utilities.Utilities

@Transactional
class TransactionReconService {

    def reconciliation(Map params, List transactions, List bankRecords, Account accountInstance) {
		
		if(accountInstance || params.accountId == "All"){
			def dates = new Utilities().getBeginningAndEndOfMonth(params.year.toInteger(), params.month.toInteger())
			def firstOfMonth = dates.firstOfMonth
			def endOfMonth = dates.endOfMonth
			def combinationId = -1
			def transactionResults = Transaction.withCriteria {
				between("transactionDate",firstOfMonth,endOfMonth+1)
				ne("verified","Y")
				if(params.accountId != "All"){
					account{
						eq("id",accountInstance.id)
					}
				}
				category{
					metaCategory{
						ne("name","UNTRACKED")
					}
				}
				order("transactionDate","desc")
				order("combinationId","desc")
			}
			
			transactionResults.each{
				if(!it.combinationId){
					transactions << ["id":it.id,
									 "transactionDate":it.transactionDate,
									 "category":it.category.name,
									 "name":it.name,
									 "amount":it.amount]
				}else{
					if(it.combinationId == combinationId){
						transactions.get(transactions.size()-1).amount += it.amount
						transactions.get(transactions.size()-1).name = "Combination Transaction"
					}else{
						transactions << ["id":it.id,
										 "transactionDate":it.transactionDate,
										 "category":it.category.name,
										 "name": it.name,
										 "amount":it.amount,
										 "combinationId":it.combinationId]
						combinationId = it.combinationId
					}
				}
			}
			
			bankRecords = BankRecord.withCriteria {
				between("transactionDate",firstOfMonth,endOfMonth+1)
				if(params.accountId != "All"){
					account{
						eq("id",accountInstance.id)
					}
				}
				isNull("transaction")
				order("transactionDate","desc")
			}
		}
		
		[transactions,bankRecords]
    }
}
