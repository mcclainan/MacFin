package planning

import category.Category
import tracking.Transaction

class BudgetItem {
	Integer year
	Integer month
	Double  amount
	String cash = "Y" 
	String required = "N"
	static belongsTo = [category: Category]
	static hasMany = [plannedTransactions: PlannedTransaction, transactions: Transaction]
	
	static constraints = {
		year blank:false, min : 2011, max : 2020,
			validator:{val,obj->
				if(val<new Date().format('yyyy').toInteger()){
					return['pastDate']
				}
			}
		month blank:false,min:1,max:12,
			validator:{val,obj->
				def date = new Date()
				if(val<date.format('MM').toInteger() && obj.year<=date.format('yyyy').toInteger()){
					return['pastDate']
				}
			}
		category unique : ["month", "year"]
		amount blank : false, min:new Double(0.0)
		cash inList : ["Y","N"]
		required blank:true ,  inList : ["Y","N"]
		
	}
	
	static namedQueries = {
		getAllByDateAndCategory{categoryId,month,year->
			if(categoryId){
				category{
					eq('id',categoryId.toLong())
				}
			}
			or{
				and{
					eq('year',year)
					ge('month',month)
				}
				
				gt('year',year)
			}
			order('year','asc')
			order('month','asc')
		}
	}
	
	static mapping = {
	}
	
	
	String toString(){
		"${category} budget ${year}/${month}"
	}
	
	public void calculateAmount(){
		Double newAmount = 0
		plannedTransactions.each{
			newAmount += it.amount
		}
		amount=newAmount
		this.save(flush:true)
	}
}

