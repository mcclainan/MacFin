package tracking

import assetLiability.AssetLiability
import planning.BudgetItem
import category.Category

class Transaction {
	
	Date created = new Date()
	Date transactionDate = new Date()
	String name
	Double amount
	String notes
	String active = "Y"
	Integer combinationId
	String relationship
	String verified = "N"
	
	static hasOne = [category: Category, 
		              account: Account, 
			   assetLiability: AssetLiability, 
			       budgetItem: BudgetItem]
	
    static constraints = {
		category nullable:false
		name nullable: false, blank: false
		amount nullable: false, blank: false
		notes nullable: true, size: 1..255
		account nullable: false
		assetLiability nullable: true
		budgetItem nullable: true
		combinationId nullable: true
		active blank: false
		verified nullable: true, inList:["Y","N"]
		relationship nullable:true
	}
	
	static mapping = {
		table name:'TRANSACTION'
		version false
		account cascade:"save-update"
	 }
	
	String toString(){
		"${transactionDate.format('MMM,dd,yyyy')} ${name}"
	}
}
