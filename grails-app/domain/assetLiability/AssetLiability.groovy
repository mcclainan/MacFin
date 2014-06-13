package assetLiability

import tracking.*
import category.Category

class AssetLiability {
	String name
	String type
	Double value
	Double interestRate
	Double creditLimit
	String active = "Y"
	AssetLiabilityClass assetLiabilityClass
	
	static hasMany = [transactions: Transaction, categories:Category]
	
    static constraints = {
		name blank: false, unique: true
		type  blank: false, size : 1..1, inList:['A','L','X']
		assetLiabilityClass  blank: false
		value  blank: false
		active  blank: false, size: 1..1, inList: ['Y','N']
		interestRate nullable: true
		creditLimit nullable: true
    }
	
	String toString(){
		"${name}"
	}
}