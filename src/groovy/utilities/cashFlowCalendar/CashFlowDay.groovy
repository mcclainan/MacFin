package utilities.cashFlowCalendar
import planning.PlannedTransaction
import tracking.Transaction
class CashFlowDay {
	Integer day = 0
	Double income = 0
	Double expense = 0
	Double amount = 0
	Double currentDayTransactionAdjustment
	Boolean isCurrentDay = false
	
	void calcCurrentTransactionAdjustment(Date currentDate){
		def incomeList = PlannedTransaction.withCriteria {
			eq('plannedTransactionDate',currentDate)
			category{
				
			}
		}
	}
}
