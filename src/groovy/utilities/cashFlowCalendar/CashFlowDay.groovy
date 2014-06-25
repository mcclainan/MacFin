package utilities.cashFlowCalendar
import planning.PlannedTransaction
import tracking.Transaction
class CashFlowDay {
	Integer day = 0
	Double income = 0
	Double expense = 0
	Double amount = 0
	Boolean isCurrentDay = false
	Double balance
	
	
	Double calcBalance(){
		balance += income-expense
	}
	
}
