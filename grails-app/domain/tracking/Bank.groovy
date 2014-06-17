package tracking

class Bank {
	String dateFormat
	String bankName
	String active = 'Y'
	String hasMultipleAmountColumns = 'N'
	String hasHeading = 'N'
	Integer dateColumn
	Integer descriptionColumn
	Integer amountColumn
	Integer creditColumn
	Integer debitColumn
	
	static hasMany = [Account accounts]
	
    static constraints = {
		active size : 1..1, inList : ["Y","N"]
		hasHeading  size : 1..1, inList : ["Y","N"]
		bankName unique:true
		creditColumn nullable:true, 
			validator:{val,obj->
				if(obj.hasMultipleAmountColumns == 'Y' && !val){
					return ['nullable']
				}
			}
		debitColumn nullable:true, 
			validator:{val,obj->
				if(obj.hasMultipleAmountColumns == 'Y' && !val){
					return ['nullable']
				}
			}
	}
	
	String toString(){
		"${bankName}"
	}
}
