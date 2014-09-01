package planning

import grails.transaction.Transactional
import tracking.Transaction
import utilities.Utilities
@Transactional
class BudgetComplianceService {

    def runReport() {
		def budgetItemInstanceList = BudgetItem.withCriteria {
			eq('year',new Date().getAt(Calendar.YEAR))
			eq('month',new Date().getAt(Calendar.MONTH)+1)
			category{
				eq('cummulative','Y')
			}
		}
		
		def report =[]
		
		if(budgetItemInstanceList?.size()>0){
			def dates = new Utilities().getBeginningAndEndOfMonth(new Date().getAt(Calendar.YEAR), new Date().getAt(Calendar.MONTH)+1)
			def transactionTotal 
			budgetItemInstanceList.each{budgetItem->
				transactionTotal = Transaction.withCriteria {
					between('transactionDate', dates.firstOfMonth,dates.endOfMonth)
					eq('category',budgetItem.category)
					projections{
						sum('amount')
					}	
				}[0]
				def totalRemaining = budgetItem.amount - Math.abs(transactionTotal?:0)
				
				report << [categoryName:budgetItem.category,totalRemaining:totalRemaining]
			}
		}
		return report
    }
}
