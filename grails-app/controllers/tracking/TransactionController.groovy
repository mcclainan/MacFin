package tracking



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import java.text.DecimalFormat
import java.util.List;
import java.util.Map;

import utilities.Utilities
import category.Category

@Transactional()
class TransactionController {
	
	def transactionService
	def transactionReconService

    static allowedMethods = [save: "POST"]

    def index(Integer max) {
        redirect(action: "singleTransaction", params: params)
    }

	def singleTransaction(Integer max) {
    	params.max = Math.min(max ?: 10, 100)
		params.order = "desc"
    	respond Transaction.listOrderByTransactionDate(params), model:[transactionInstanceCount: Transaction.count(),transactionInstance:new Transaction()]
    }

    def show(Transaction transactionInstance) {
        respond transactionInstance
    }

    def create() {
        respond new Transaction(params)
    }

    @Transactional
    def save(Transaction transactionInstance) {
        if (transactionInstance == null) {
            notFound()
            return
        }

        if (transactionInstance.hasErrors()) {
            respond transactionInstance.errors, view:'create'
            return
        }

		transactionService.create(transactionInstance) 
		transactionInstance.save()

		request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'transactionInstance.label', default: 'Transaction'), transactionInstance])
                redirect action:"singleTransaction"
            }
            '*' { respond transactionInstance, [status: CREATED] }
        }
    }
	

    def edit(Transaction transactionInstance) {
        respond transactionInstance
    }

//    @Transactional
//    def update(Transaction transactionInstance) {
//        if (transactionInstance == null) {
//            notFound()
//            return
//        }
//
//        if (transactionInstance.hasErrors()) {
//            respond transactionInstance.errors, view:'edit'
//            return
//        }
//		
//		Transaction oldTransaction = new Transaction()
//		println "\n oldTransaction ${oldTransaction}"
//		println "newTransaction ${transactionInstance}\n"
//
//		bindData(oldTransaction,Transaction.get(transactionInstance.id).properties,['id','verson'])
//		
//		println "oldTransaction ${oldTransaction}"
//		println "newTransaction ${transactionInstance}\n"
//		
//		transactionInstance.properties = params
//
//		println "oldTransaction ${oldTransaction}"
//		println "newTransaction ${transactionInstance}\n"
//		
//        transactionInstance.save flush:true
//		transactionService.edit(transactionInstance,oldTransaction)
//
//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.updated.message', args: [message(code: 'Transaction.label', default: 'Transaction'), transactionInstance.id])
//                redirect action:"singleTransaction"
//            }
//            '*'{ respond transactionInstance, [status: OK] }
//        }
//    }

	def update() {
		def transactionInstance = Transaction.get(params.id)
		if (!transactionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'transaction.label', default: 'Transaction'), params.id])
			redirect(action: "singleTransaction")
			return
		}
		
		if(transactionInstance.relationship == 'child'){
			flash.message = message(code: 'child.transaction.read.only', args: [transactionInstance, Transaction.findByNameAndAmount(transactionInstance.name.replace('CC Procedes for ',''),transactionInstance.amount * (-1))])
			redirect(action: "singleTransaction")
			return
		}

		if (params.version) {
			def version = params.version.toLong()
			if (transactionInstance.version > version) {
				transactionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						  [message(code: 'transaction.label', default: 'Transaction')] as Object[],
						  "Another user has updated this Transaction while you were editing")
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			params.order = "desc"
			render(view: "singleTransaction", model: [transactionInstance: transactionInstance,transactionInstanceList: Transaction.listOrderByTransactionDate(params), transactionInstanceCount: Transaction.count()])
			return
			}
		}
		
		Transaction oldTransaction = new Transaction()
		
		bindData(oldTransaction,transactionInstance.properties,['id','verson'])
		transactionInstance.properties = params

		if (!transactionInstance.save(flush: true)) {
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			params.order = "desc"
			render(view: "singleTransaction", model: [transactionInstance: transactionInstance,transactionInstanceList: Transaction.listOrderByTransactionDate(params), transactionInstanceCount: Transaction.count()])
			return
		}
		
		transactionService.edit(transactionInstance,oldTransaction)

		flash.message = message(code: 'default.updated.message', args: [message(code: 'transaction.label', default: 'Transaction'), transactionInstance])
		redirect(action: "singleTransaction")
	}
	
    @Transactional
    def delete(Transaction transactionInstance) {

        if (transactionInstance == null) {
            notFound()
            return
        }
		
		if(transactionInstance.relationship == 'child'){
			flash.message = message(code: 'child.transaction.read.only', args: [transactionInstance, Transaction.findByNameAndAmount(transactionInstance.name.replace('CC Procedes for ',''),transactionInstance.amount * (-1))])
			redirect(action: "singleTransaction")
			return
		}
		def transactionStr = transactionInstance.toString()
		transactionService.delete(transactionInstance)
        transactionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Transaction.label', default: 'Transaction'), transactionStr])
                redirect action:"singleTransaction"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
	
	def search(){
		params.order = "desc"
		params.max = 10
		params.each{
			println it
		}
		Boolean validSearch = true
		Double amount
		flash.searchErrors = [:]
		if(params.searchAmount){
			try{
				amount = params.searchAmount.toDouble()
			}catch(Exception ex){
				validSearch	= false
				flash.searchErrors.amount = "Amount must be a valid number with no symbols other than one '.'"
			}
		 }
		def transactions = []
		println "params.amount ${params.amount}"
		println "amount ${amount}"
		if(validSearch){  
			println "Valid Search" 
			def searchParams = [:]
			def transactionCriteria = Transaction.createCriteria()
			transactions = transactionCriteria.list(params) {
			
				if(params.dateSearchOption == "By Month"){
					println "Searching By Month"
					def dates = new Utilities().getBeginningAndEndOfMonth(params.searchMonth.format("yyyy").toInteger(), params.searchMonth.format("MM").toInteger())
							def startDate = dates.firstOfMonth
							def endDate = dates.endOfMonth
							searchParams.searchMonth = params.searchMonth
							between("transactionDate", startDate, endDate)
				}else if(params.dateSearchOption == "By Date"){
					println "Searching By Date"
					eq("transactionDate",params.searchDate)
					searchParams.searchDate = params.searchDate
				}else if(params.dateSearchOption == "By Date Range"){
					println "Searching By Date Range"
					between("transactionDate", params.startDate,params.endDate)
					searchParams.startDate = params.startDate
					searchParams.endDate = params.endDate
				}
				
				if(params.searchCategoryId != "null" && params.searchCategoryId != null){
					println "Searching By Category"
					category{
						eq("id",params.searchCategoryId.toLong())
					}
					searchParams.searchCategoryId = params.searchCategoryId
				}
				
				if(params.searchName){
					println "Searching By name"
					ilike("name", "%${params.searchName}%")
					searchParams.searchName = params.searchName
				}
				
				if(amount){
					println "Searching By amount"
					between("amount",amount-10,amount+10)
					searchParams.searchAmount = params.searchAmount
				}
				
				if(params.searchAccountId != "null" && params.searchAccountId != null){
					println "Searching By Account"
					account{
						eq("id",params.searchAccountId.toLong())
					}
					searchParams.searchAccountId = params.searchAccountId
				}			
				
				if(params.searchAssetLiabilityId != "null" && params.searchAssetLiabilityId != null){
					println "Searching By Account Asset Liability"
					assetLiability{
						eq("id",params.searchAssetLiabilityId.toLong())
					}
					searchParams.searchAssetLiabilityId = params.searchAssetLiabilityId
				}
				
				order("transactionDate", "desc")
			}
			
			searchParams.each{
				println "search parameter :${it}"
			}
			
			render(view:"singleTransaction", 
				   model:[transactionInstanceList:transactions, 
					      transactionInstanceCount:transactions?.getTotalCount()?:0,
						  transactionInstance: new Transaction(), 
						  searchParams:searchParams])
		}else{
			println "InValid Search"
			redirect(action:"singleTransaction")
		}
	}
		
	def combinationTransaction(){
		def amount
		if(!params.totalEntered){
			session.newTransactions = []
			session.transactionDate = new Date()
			flash.message = null
			
			render(view:"combinationTransactionTotal", model:[amount:params.amount?:0])
		}else{
			try{
				amount = params.amount.toDouble()
			}catch(NumberFormatException ex){
				flash.errors << ["Invlaid Amount":"Amount Field must be numbers only, with only on demimal (.) allowed"]
				render(view:"combinationTransactionTotal", model:[amount:params.amount])
			}
			def transaction = new Transaction()
			render(view:"combinationTransaction", model:[transactionInstance:transaction, totalAmount:amount])
//			[transactionInstance:transaction, totalAmount:amount]
		}
	}
	
	def createCombinationTransaction(){
		def totalAmount = Double.parseDouble(new DecimalFormat("#.##").format(params.hiddenTotalAmount.toDouble()))
		def amount = Double.parseDouble(new DecimalFormat("#.##").format(params.amount.toDouble()))
		def cashBackDone = params.cashBackDone
		def dateLock = ""
		
		def transactionInstance = new Transaction()
		
		bindData(transactionInstance,params,["amount","transactionDate"])
		
		if(!session.transactionDate){
			session.transactionDate = params.transactionDate
			println "session.transactionDate = params.transactionDate"
		}else{
			transactionInstance.transactionDate = params.transactionDate
			println "transactionInstance.transactionDate = params.transactionDate"
		}
		
		if(params.dateLock){
			dateLock = "disabled"
			transactionInstance.transactionDate = session.transactionDate
			println "dateLock = disabled transactionInstance.transactionDate = session.transactionDate"
		}
		
		
		if(params.amount){
			try{
				amount = params.amount.toDouble()
				if(amount > totalAmount){
					amount = totalAmount
				}
			}catch(NumberFormatException ex){
				flash.errors << ["Invlaid Amount":"Amount Field must be numbers only, with only on demimal (.) allowed"]
				transactionInstance.amount = 0
			}
		}
		transactionInstance.amount = amount
		 
		if (!transactionInstance.validate() || flash.errors) {
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			params.order = "desc"
			render(view:"combinationTransaction",model:[transactionInstance:transactionInstance, totalAmount:totalAmount, dateLock:dateLock,amount:params.amount])
			return
		}
		 
		if(!session.newTransactions){
			session.newTransactions = [:]
		}
		
		session.newTransactions."Transacton${session.newTransactions.size()}" = transactionInstance
		totalAmount -= Math.abs(amount)
		
		if(params.cashBack && cashBackDone != "true"){
			def outTransaction = new Transaction(category: category.Category.findByName("ACCOUNT TRANSFER OUT"), name:"Debit Cash Back", amount: params.cashBack.toDouble(), account:Account.get(params.account.id), transactionDate:session.transactionDate)
			session.newTransactions."Transacton${session.newTransactions.size()}" = outTransaction
			def inTransaction = new Transaction(category: category.Category.findByName("ACCOUNT TRANSFER IN"), name:"Debit Cash Back", amount: params.cashBack.toDouble(), account:Account.findByName("CASH"), transactionDate:session.transactionDate)
			session.newTransactions."Transacton${session.newTransactions.size()}" = inTransaction
			totalAmount -= Math.abs(params.cashBack.toDouble())
			cashBackDone = "true"
		}
		 
		if(totalAmount <= 0){
			flash.message = "Review the pending transactions list. Click Save when ready"
		}
		
		println "Showing transaction on session"
		session.newTransactions.each{
			def transaction = it.value
			println "${transaction.category} transaction with date of ${transaction.transactionDate}"
		}

		render(view:"combinationTransaction",model:[transactionInstance:new Transaction(), totalAmount:totalAmount, dateLock:dateLock,account:params.account.id,cashBackDone:cashBackDone])
	}
	
	@Transactional
	def saveCombinationTransactions(){
		
		def comboId = Integer.parseInt(System.currentTimeMillis().toString().substring(7))
		int i = 1
		def accountID = 0
		def amount = 0
		def cashBack = 0

		session.newTransactions.each{
			Transaction transaction = it.value
			
			if(transaction){
				transaction.combinationId = comboId
				transactionService.create(transaction)
				
				/*The following code is a work around because account balances were not being updated
				 *properly with saving of each transaction*/
				
				if(!accountID){
					accountID = transaction.account.id
					amount += transaction.amount
				}else if(accountID != transaction.account.id){
					println "Added cash back amount"
					cashBack = transaction.amount
				}else{
					amount += transaction.amount
				}/*end this part of work around*/
				
				if(transaction.validate()){
					transaction.save flush:true
				}else{
					transaction.errors.each{
						println it
					}
				}
			}
		}
		
		/*Finish work around here*/
		def account = Account.get(accountID)
		account.balance += amount
		account.save flush:true
		
		if(cashBack){
			def accountCash = Account.findByName("CASH")
			accountCash.balance += cashBack
			accountCash.save flush:true
		}/*end work around*/
		
		def transactionTotal = 0
		session.newTransactions.each{
			transactionTotal += it.value.amount
		}
		flash.message = "${session.newTransactions.size()} transactions were created whith a net total of \$${transactionTotal}"
		session.newTransactions = null
		redirect(action:"singleTransaction")
	}
	
	def removeTransactionFromCombo(){
		def totalAmount = params.amount.toDouble()
		totalAmount += Math.abs(session.newTransactions."${params.transactionKey}".amount)
		session.newTransactions.remove(params.transactionKey)
		render(view:"combinationTransaction",model:[transactionInstance:new Transaction(), totalAmount:totalAmount, dateLock:"disabled"])
		
	}

	def accountTransfer(){
		def transaction = new Transaction()
		[transactionInstance:transaction]
	}
	
	def createAccountTransfer(){
		
		def transactionTo = new Transaction()
		bindData(transactionTo,params,["amount"])
		def transactionFrom = new Transaction()
		bindData(transactionFrom,params,["amount"])
		flash.errors = [:]
		
		try{
			def amount = params.amount.toDouble()
			transactionFrom.amount = amount
			transactionTo.amount = amount
		}catch(NumberFormatException ex){
			flash.errors << ["Invlaid Amount":"Amount Field must be numbers only, with only on demimal (.) allowed"]
		}
		
		
		transactionTo.account = Account.get(params.toAccountId)
		transactionFrom.account = Account.get(params.fromAccountId)
		
		transactionTo.category =  Category.findByName("ACCOUNT TRANSFER IN")
		transactionFrom.category =  Category.findByName("ACCOUNT TRANSFER OUT")
		
		if(params.transferFee){
			try{
			def amount = params.transferFee.toDouble()
				transactionFrom.amount += amount
			}catch(NumberFormatException ex){
				flash.errors << ["Invlaid Transfer Fee":"Transfer Fee Field must be numbers only, with only on demimal (.) allowed"]
			}
		}
		
		if(flash.errors){
			render(view:"accountTransfer", model:[transactionInstance:new Transaction()])
			return
		}
		if(!(transactionFrom.validate() || transactionTo.validate())){
			render(view:"accountTransfer", model:[transactionInstance:transactionFrom])
			return
		}
		
		transactionService.create(transactionTo)
		transactionTo.save flush:true
		transactionService.create(transactionFrom)
		transactionFrom.save flush:true
		
		flash.message = "Transfer from ${transactionFrom.account} to ${transactionTo.account} in the amount of ${transactionTo.amount} was successful"
		if(params.createAnother == 'on'){
			redirect(action:'accountTransfer')
		}else{
			redirect(action:"singleTransaction")
		}
	}

	
	
	def reconciliation(){
		
		Account accountInstance
		if(params.accountId && params.accountId != "All"){
			accountInstance = Account.get(params.accountId)
		}
		def month = params.month?:new Date().format("MM").toInteger()
		def year = params.year?:new Date().format("yyyy").toInteger()
		List transactions = []
		List bankRecords = []
		
		def lists = transactionReconService.reconciliation(params,transactions,bankRecords,accountInstance)
		[month:month , year:year , accountId:params.accountId, transactionInstanceList:lists.get(0) , bankRecordInstanceList:lists.get(1)]
	}
	
	def getTransactionsForRecon(){
		List transactions = []
		def combinationId = -1
		def bankRecord = BankRecord.get(params.id)
		def transactionResults = Transaction.withCriteria {
			between("transactionDate", bankRecord.transactionDate - 4, bankRecord.transactionDate + 3)
			between("amount", bankRecord.amount - 5, bankRecord.amount + 5 )
			ne("verified","Y")
			if(!session.allAccounts){
				eq("account", bankRecord.account)
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
		
		render(view:"_reconTransactionList.gsp", model:[transactionInstanceList:transactions,selectList:true, bankRecord:bankRecord])
	}
	
	@Transactional
	def saveFromRecon() {
		def transactionInstance = new Transaction(params)
		def bankRecord = BankRecord.get(params.bankRecordId)
		
		if (transactionInstance == null) {
			notFound()
			return
		}
		
		if (transactionInstance.hasErrors()) {
			respond transactionInstance.errors, view:'create'
				return
		}
		
		transactionService.create(transactionInstance)
		bankRecord.transaction = transactionInstance
		transactionInstance.save()
		bankRecord.save()
		
		redirect action:"reconciliation",params:[year:transactionInstance.transactionDate.getAt(Calendar.YEAR),
												  month:transactionInstance.transactionDate.getAt(Calendar.MONTH)+1,
												 accountId:transactionInstance.account.id]
	}
	
	def toggleAllAccounts(){
		def message
		if(!session.allAccounts){
			session.allAccounts = true
			message = "Look at Transactions that only match Bank Record Accounts"
		}else{
			session.allAccounts = false
			message = "Look at Transactions from all Accounts"
		}
		render message
	}
	
	def singleTransactionForRecon(){
		def bankRecord = BankRecord.get(params.id)
		Transaction transactionInstance = new Transaction()
		transactionInstance.amount = bankRecord.amount
		transactionInstance.transactionDate = bankRecord.transactionDate
		def description  = bankRecord.description
		if(description.contains("~")){
			description = description.substring(0,description.indexOf("~"))
		}
		transactionInstance.name = description
		transactionInstance.account = bankRecord.account
		
		render(template:"reconTransactionForm", model:[transactionInstance:transactionInstance, bankRecordId:bankRecord.id])
	}
	
	def verify(){
		Transaction transactionInstance = Transaction.get(params.transactionId)
		BankRecord bankRecordInstance = BankRecord.get(params.bankRecordId)
		
		if(transactionInstance.combinationId){
			List transactionList = Transaction.withCriteria{
				eq("combinationId",transactionInstance.combinationId)
				account{
					eq("id",params.accountId.toLong())
				}
			}
			
			Double totalAmount = 0
			transactionList.each {
				totalAmount += it.amount
			}
			
			if(totalAmount != bankRecordInstance.amount){
				int multiplier = 1
				if(totalAmount < 0){
					multiplier = -1
				}
				def addAmount = (Math.abs(bankRecordInstance.amount) - Math.abs(totalAmount))/transactionList.size()
				addAmount *= multiplier
				transactionList.each {
					Transaction oldTransaction = new Transaction()
					bindData(oldTransaction,it.properties,['id','verson'])
					it.amount += addAmount
					it.account = bankRecordInstance.account
					transactionService.edit(it,oldTransaction)
				}
			}
			
			transactionList.each {
				it.verified = "Y"
				it.save(flush:true)
			}
			
		}else{
			Transaction oldTransaction = new Transaction()
			bindData(oldTransaction,transactionInstance.properties,['id','verson'])
			transactionInstance.amount = bankRecordInstance.amount
			transactionInstance.account = bankRecordInstance.account
			transactionService.edit(transactionInstance,oldTransaction)
			transactionInstance.verified = "Y"
			transactionInstance.save(flush:true)
		}
		bankRecordInstance.transaction = transactionInstance
		bankRecordInstance.save(flush:true)
		redirect(action:"reconciliation",params:params)
	}
	
	protected void notFound() {
		request.withFormat {
			form multipartForm {
				flash.message = message(code: 'default.not.found.message', args: [message(code: 'transactionInstance.label', default: 'Transaction'), params.id])
				redirect action: "index", method: "GET"
			}
			'*'{ render status: NOT_FOUND }
		}
	}
	
}
