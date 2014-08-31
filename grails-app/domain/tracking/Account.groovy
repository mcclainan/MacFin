package tracking

import assetLiability.AssetLiability

class Account {
	String name
	Double balance
	Double interestRate
	String active = "Y"
	String cash
	AssetLiability assetLiability
	String type
	
	static hasMany = [transactions: Transaction]
	static belongsTo = [bank:Bank]
	
    static constraints = {
		interestRate nullable : true
		active size : 1..1, inList : ["Y","N"]
		cash  size : 1..1, inList : ["Y","N"]
		assetLiability nullable: true
		bank nullable:true
		type inList:['bank','school','brokerage']
    }
	
	static namedQueries = {
		findAllByBankNotNull{
			isNotNull('bank')
		}
		calcSumByCash{
			eq('cash','Y')
			projections{
				sum('balance')
			}
		}
	}
	String toString(){
		"${name}"
	} 
	
}
