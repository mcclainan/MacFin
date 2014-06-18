import grails.util.Environment;

import java.text.DecimalFormat

import com.sun.org.apache.xalan.internal.xsltc.compiler.ForEach;

import assetLiability.AssetLiability
import assetLiability.AssetLiabilityClass
import category.*
import tracking.*
import planning.*
import utilities.Random

class BootStrap {
	def account
	def transaction
	def assetLiability
	def budgetItem
	def metaCategory
	def assetLiabilityClass
	def plannedTransaction
	def category
	def bank
	
    def init = { servletContext ->
		println "Initializing"
		switch(Environment.current){
			case Environment.DEVELOPMENT:
				createTestData()
				break;
		}
		def monthNames = [(1):"January", (2):"February",(3):"March",(4): "April", (5):"May", (6):"June", (7):"July", (8):"August", (9):"September", (10):"October", (11):"November",(12):"December"]
		def monthNumbers = [("January"):1, ("February"):2,("March"):3,("April"): 4 , ("May"): 5, ("June"): 6, ("July"):7, ("August"):8, ("September"):9, ("October"):10, ("November"):11,("December"):12]
		servletContext.setAttribute("monthNames", monthNames)
		servletContext.setAttribute("monthNumbers", monthNumbers)
    }
	
	def createTestData(){
		createMetaCategory()
		createCategory()
		createBudgetItem()
		createBank()
		createAccount()
		createAssetLiabilityClass()
		createAssetLiability()
		createYearBeginningResourcess()
		createTransactions()
	}
	
	def createMetaCategory(){
		println "Creating Meta Category"
		def metacategory = new MetaCategory(name: "HOUSING")
		metacategory.save()
		
		metacategory = new MetaCategory(name: "FOOD")
		metacategory.save()
		
		metacategory = new MetaCategory(name: "TRANSPORTATION")
		metacategory.save()
		
		metacategory = new MetaCategory(name: "EDUCATION")
		metacategory.save()
		
		metacategory = new MetaCategory(name: "ENTERTAINMENT")
		metacategory.save()
		
		metacategory = new MetaCategory(name: "FINANCING")
		metacategory.save()

		metacategory = new MetaCategory(name: "JOB")
		metacategory.save()
		
		metacategory = new MetaCategory(name: "ADJUSTMENT")
		metacategory.save()
		
		metacategory = new MetaCategory(name: "TRANSFERS")
		metacategory.save()

		metacategory = new MetaCategory(name: "INVESTMENT")
		metacategory.save()
	}
	def createCategory(){
		println "Creating Category"
		def metacategory = MetaCategory.findByName("HOUSING")
		def category = new Category(name:"Rent", cash:"Y",type:"E", metaCategory:metacategory)
		category.save()
		category = new Category(name:"Utilities", cash:"Y",type:"E",metaCategory:metacategory)
		category.save()
		category = new Category(name:"Cleaning Supplies", cash:"Y",type:"E",metaCategory:metacategory)
		category.save()		
		
		metacategory = MetaCategory.findByName("FOOD")
		category = new Category(name:"Groceries", cash:"Y",type:"E",metaCategory:metacategory)
		category.save()
		category = new Category(name:"Out of Home Food", cash:"Y",type:"E",metaCategory:metacategory)
		category.save()
		
		metacategory = MetaCategory.findByName("TRASPORTATION")
		category = new Category(name:"Fuel", cash:"Y",type:"E",metaCategory:metacategory)
		category.save()
		category = new Category(name:"Maintenance", cash:"Y",type:"E",metaCategory:metacategory)
		category.save()
		
		metacategory = MetaCategory.findByName("EDUCATION")
		category = new Category(name:"Tuition", cash:"Y",type:"E",metaCategory:metacategory)
		category.save()
		category = new Category(name:"School Supplies", cash:"Y",type:"E",metaCategory:metacategory)
		category.save()
		
		
		metacategory = MetaCategory.findByName("ENTERTAINMENT")
		category = new Category(name:"Movies", cash:"Y",type:"E",metaCategory:metacategory)
		category.save()
		category = new Category(name:"Family Outing", cash:"Y",type:"E",metaCategory:metacategory)
		category.save()
		
		metacategory = MetaCategory.findByName("FINANCING")
		category = new Category(name:"Loan - Proceedes", cash:"Y",type:"I",metaCategory:metacategory,assetLiabilityAction:1)
		category.save()
		category = new Category(name:"Loan - Payment", cash:"Y",type:"E",metaCategory:metacategory,assetLiabilityAction:-1)
		category.save()
		category = new Category(name:"Loan - Interest", cash:"N",type:"E",metaCategory:metacategory,assetLiabilityAction:1)
		category.save()
		category = new Category(name:"Credit Card - Use", cash:"Y",type:"I",metaCategory:metacategory,assetLiabilityAction:1)
		category.save()
		category = new Category(name:"Credit Card - Payment", cash:"Y",type:"E",metaCategory:metacategory,assetLiabilityAction:-1)
		category.save()
		category = new Category(name:"Credit Card - Interest", cash:"N",type:"E",metaCategory:metacategory,assetLiabilityAction:1)
		category.save()
		category = new Category(name:"Credit Card-Proceedes", cash:"N",type:"E",metaCategory:metacategory,assetLiabilityAction:1)
		category.save()
		
		metacategory = MetaCategory.findByName("INVESTMENT")
		category = new Category(name:"Investment - Purchase", cash:"Y",type:"E",metaCategory:metacategory,assetLiabilityAction:1)
		category.save()
		category = new Category(name:"Investment - Sale", cash:"Y",type:"I",metaCategory:metacategory,assetLiabilityAction:-1)
		category.save()
		category = new Category(name:"Investment - Appreciation", cash:"N",type:"I",metaCategory:metacategory,assetLiabilityAction:1)
		category.save()
		category = new Category(name:"Investment - Deppreciation", cash:"N",type:"E",metaCategory:metacategory,assetLiabilityAction:-1)
		category.save()
		

		metacategory = MetaCategory.findByName("JOB")
		category = new Category(name:"Tony Job", cash:"Y",type:"I",metaCategory:metacategory)
		category.save()
		category = new Category(name:"Kia Job", cash:"Y",type:"I",metaCategory:metacategory)
		category.save()
		
		
		metacategory = MetaCategory.findByName("TRANSFERS")
		category = new Category(name:"ACCOUNT TRANSFER IN", cash:"Y",type:"I",metaCategory:metacategory)
		category.save()
		category = new Category(name:"ACCOUNT TRANSFER OUT", cash:"Y",type:"E",metaCategory:metacategory)
		category.save()
		
		
	}
	def createBudgetItem(){
		println "Creating Budget Items"
		category = Category.findByName('Rent')
		def year = new Date().format('yyyy').toInteger()
		def month = new Date().format('MM').toInteger()
		for(int i=0;i<6;i++){
			budgetItem = new BudgetItem(year:year,
										month:month++,
										amount:800,
										category:category,
										required:'Y')
			budgetItem.save()
			createPlannedTransactions(budgetItem)
		}
	}
	def createPlannedTransactions(BudgetItem budgetItem){
		def date = new Date()
		date.set(year:budgetItem.year,month:budgetItem.month,date:1)
		plannedTransaction = new PlannedTransaction(plannedTransactionDate:date,
													amount:budgetItem.amount,
													rolling:'Y',
													budgetItem:budgetItem,
													category:budgetItem.category)
		plannedTransaction.validate()
		plannedTransaction.errors?.each{
			println it
		}
		plannedTransaction.save()
	}
	def createBank(){
		println "Creating Bank"
		bank = new Bank(bankName:'USAA',dateFormat:'MM/dd/yyy',dateColumn:2,descriptionColumn:4,amountColumn:6)
		bank.save()
	}
	def createAccount(){
		println "Creating Accounts"
		
		account = new Account(name:"NO RESOURCE",balance: 0, cash:"N")
		account.save()
		
		account = new Account(name:"Tony Checking",balance: 1500, cash:"Y",bank:bank)
		account.save()
		
		account = new Account(name:"Kia Checking",balance: 0, cash:"Y",bank:bank)
		account.save()
		
		account = new Account(name:"Joint Checking",balance: 0, cash:"Y",bank:bank)
		account.save()
		
		account = new Account(name:"CASH",balance: 0, cash:"Y")
		account.save()
		
		account = new Account(name:"Bank Credit Card",balance: 0, cash:"N")
		account.save()
	}
	def createAssetLiabilityClass(){
		def assetLiabilityClass
		println "Creating AssetLiabilityClass Test Data"
		if(!AssetLiabilityClass.findByName("LOAN")){
			assetLiabilityClass = new AssetLiabilityClass(name: "LOAN", onProceedes : 1, onPayment : -1, onInterest : 1).save(flush: true)
		}
		if(!AssetLiabilityClass.findByName("Credit Card")){
			assetLiabilityClass = new AssetLiabilityClass(name: "CREDIT CARD", onProceedes : 1, onPayment : -1, onInterest : 1, onUse : 1).save(flush: true)
		}
		if(!AssetLiabilityClass.findByName("Investment")){
			assetLiabilityClass = new AssetLiabilityClass(name: "Investment", onSale : -1, onPurchase : 1, onAppreciation: 1, onDepreciation: 1).save(flush: true)
		}
	}
	def createAssetLiability(){
		println "Creating Asset/Liability Test Data"
		if(!AssetLiability.findByName("Loan")){
			assetLiability = new AssetLiability(name: "Loan", assetLiabilityClass: AssetLiabilityClass.findByName("LOAN"), type:"L", active: "Y", value: 900).save(flush: true)
			category = Category.findByName('Loan - Proceedes')
			category.assetLiability = assetLiability
			category.save()
			category = Category.findByName('Loan - Payment')
			category.assetLiability = assetLiability
			category.save()
			category = Category.findByName('Loan - Interest')
			category.assetLiability = assetLiability
			category.save()
		}
		if(!AssetLiability.findByName("Credit Card")){
			assetLiability = new AssetLiability(name: "Credit Card", assetLiabilityClass: AssetLiabilityClass.findByName("CREDIT CARD"), type:"L", active: "Y", value: 0, creditLimit: 500).save(flush: true)
			category = Category.findByName('Credit Card - Use')
			category.assetLiability = assetLiability
			category.save()
			category = Category.findByName('Credit Card - Interest')
			category.assetLiability = assetLiability
			category.save()
			category = Category.findByName('Credit Card - Payment')
			category.assetLiability = assetLiability
			category.save()
			category = Category.findByName('Credit Card-Proceedes')
			category.assetLiability = assetLiability
			category.save()
			account = Account.findByName("Bank Credit Card")
			account.assetLiability = assetLiability
			account.save(flush:true)
		}
		
		if(!AssetLiability.findByName("Investment")){
			assetLiability = new AssetLiability(name: "Investment", assetLiabilityClass: AssetLiabilityClass.findByName("Investment"), type:"A", active: "Y", value: 450).save(flush: true)
			category = Category.findByName('Investment - Purchase')
			category.assetLiability = assetLiability
			category.save()
			category = Category.findByName('Investment - Sale')
			category.assetLiability = assetLiability
			category.save()
			category = Category.findByName('Investment - Appreciation')
			category.assetLiability = assetLiability
			category.save()
			category = Category.findByName('Investment - Deppreciation')
			category.assetLiability = assetLiability
			category.save()
		}
		
	}
	def createYearBeginningResourcess(){
		
	}
	def createTransactions(){
		println "Creating Transactions"
		//Transactions Set for current month
		account = Account.findByName("Tony Checking")
		def category = Category.findByName("Rent")
		def incrimenter = 0
		def date = new Date()
		def stopDay = date.format("dd").toInteger()
		def month = date.format("MM").toInteger()-1
		
		def transaction = createTransactionHelper(category,account,"Rent",-700,1,month)
		transaction.save()
		
		category = Category.findByName("Utilities")
		transaction = createTransactionHelper(category,account,"Utilities",-300,1,month)
		def bankRecord = new BankRecord(amount:transaction.amount, transactionDate:transaction.transactionDate, account:transaction.account, description:"${transaction.name}~~~~5646546546~ blah blah")
		bankRecord.save()
		transaction.save()
		
		category = Category.findByName("Groceries")
		for(int i = 1;i<stopDay;i++){
			transaction = createTransactionHelper(category,account,"Food",Double.parseDouble(new DecimalFormat("#.##").format(Random.getRandomDoubleWithRange(-25,-35))),i,month)
			bankRecord = new BankRecord(amount:transaction.amount, transactionDate:transaction.transactionDate, account:transaction.account, description:transaction.name)
			bankRecord.save()
			transaction.save()
		}
		category = Category.findByName("Fuel")
		for(int i = 1;i<stopDay;i+=5){
			transaction = createTransactionHelper(category,account,"Fuel",Double.parseDouble(new DecimalFormat("#.##").format(Random.getRandomDoubleWithRange(-30,-65))),i,month)
			transaction.save()
		}
		
		category = Category.findByName("Out of Home Food")
		for(int i = 1;i<stopDay;i+=3){
			transaction = createTransactionHelper(category,account,"Take out Food",Double.parseDouble(new DecimalFormat("#.##").format(Random.getRandomDoubleWithRange(-10,-25))),i,month)
			transaction.save()
		}
		
		category = Category.findByName("Movies")
		for(int i = 1;i<stopDay;i+=7){
			transaction = createTransactionHelper(category,account,"Movie",Double.parseDouble(new DecimalFormat("#.##").format(Random.getRandomDoubleWithRange(-10,-20))),i,month)
					transaction.save()
		}
		
		category = Category.findByName("Tony Job")
		transaction = createTransactionHelper(category,account,"PayCheck",1400,1,month)
		transaction.save()
		
		if(stopDay >= 15){
			transaction = createTransactionHelper(category,account,"PayCheck",1400,15,month)
			transaction.save()
		}
		
		
		//Transactions Set for previous month
		month = month - 1
		category = Category.findByName("Rent")
		transaction = createTransactionHelper(category,account,"Rent",-700,1,month)
		transaction.save()
		
		category = Category.findByName("Utilities")
		transaction = createTransactionHelper(category,account,"Utilities",-300,1,month)
		transaction.save()
		
		category = Category.findByName("Groceries")
		for(int i = 1;i<30;i++){
			transaction = createTransactionHelper(category,account,"Food",Double.parseDouble(new DecimalFormat("#.##").format(Random.getRandomDoubleWithRange(-25,-35))),i,month)
					transaction.save()
		}
		category = Category.findByName("Fuel")
		for(int i = 1;i<30;i+=5){
			transaction = createTransactionHelper(category,account,"Fuel",Double.parseDouble(new DecimalFormat("#.##").format(Random.getRandomDoubleWithRange(-30,-65))),i,month)
					transaction.save()
		}
		
		category = Category.findByName("Out of Home Food")
		for(int i = 1;i<30;i+=3){
			transaction = createTransactionHelper(category,account,"Take out Food",Double.parseDouble(new DecimalFormat("#.##").format(Random.getRandomDoubleWithRange(-10,-25))),i,month)
					transaction.save()
		}
		
		category = Category.findByName("Movies")
		for(int i = 1;i<30;i+=7){
			transaction = createTransactionHelper(category,account,"Movie",Double.parseDouble(new DecimalFormat("#.##").format(Random.getRandomDoubleWithRange(-10,-20))),i,month)
					transaction.save()
		}

		category = Category.findByName("Tony Job")
		transaction = createTransactionHelper(category,account,"PayCheck",1400,1,month)
		transaction.save()
		
		transaction = createTransactionHelper(category,account,"PayCheck",1400,15,month)
		transaction.save()
		
	}
	
	private Transaction createTransactionHelper(Category category, Account account,String name,Double amount, Integer day, Integer month){
		def date = new Date()
		if(day)date.set(date:day)
		if(month)date.set(month:month)
		def transaction = new Transaction(category: category, name:name, amount: amount, account:account, transactionDate:date)
		return transaction
	}
    def destroy = {
    }
}
