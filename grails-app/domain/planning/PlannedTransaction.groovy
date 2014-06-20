package planning
import category.Category

class PlannedTransaction {
	Date plannedTransactionDate
	Double amount
	String cash = "Y"
	String exempt = "N"
	String rolling = "N"
	
	static belongsTo = [budgetItem: BudgetItem]
	static hasOne = [category:Category]
	
	static constraints = {
		plannedTransactionDate blank:false
		amount blank: false
		cash inList : ["Y","N"]
		exempt inList : ["Y","N"]
		rolling nullable:true , inList : ["Y","N"]
		category nullablie:true
	}
	
	String toString(){
		"Planned Transaction, amount ${amount} on day ${plannedTransactionDate.format('dd')} for ${budgetItem}"
	}
	
	static namedQueries = {
		findIncomeDailyTotalsByDateRange{startDate,endDate->
			between("plannedTransactionDate",startDate-1,endDate)
			category{
				eq("type","I")
			}
			projections{
				groupProperty("plannedTransactionDate")
				sum("amount")
			}
		}
		findExpenseDailyTotalsByDateRange{startDate,endDate->
			between("plannedTransactionDate",startDate-1,endDate)
			category{
				eq("type","E")
			}
			projections{
				groupProperty("plannedTransactionDate")
				sum("amount")
			}
		}
		findAllByDateRangeAndCategory{startDate,endDate,categoryInstance->
			between("plannedTransactionDate",startDate-1,endDate)
			category{
				eq("id",categoryInstance.id)
			}
			projections{
				groupProperty("plannedTransactionDate")
				sum("amount")
			}
		}
	}
}

