package utilities.cashFlowCalendar
import java.util.Date;
import planning.*
import utilities.Utilities
import tracking.*

class CashFlowCalendar {
	Boolean forBudgetShow = false
	List<CashFlowMonth> cashFlowMonthList = []
	
	public CashFlowCalendar(Date startDate,Integer numberOfMonths){
		def year = startDate.format('yyyy').toInteger()
		def month = startDate.format('MM').toInteger()
		def endDate = Utilities.getEndOfMonth(year,month)
		def balance = calcInitialBalance(startDate)
		def cfMonth = new CashFlowMonth(startDate,endDate,balance)
		cashFlowMonthList<<cfMonth
		balance = cfMonth.balance
		for(int i=1;i<numberOfMonths;i++){
			month++
			if(month>12){
				month = 1
				year++
			}
			def dates = new Utilities().getBeginningAndEndOfMonth(year, month)
			cfMonth = new CashFlowMonth(dates.firstOfMonth,dates.endOfMonth,balance)
			balance = cfMonth.balance
			cashFlowMonthList<< cfMonth
		}
	}
	
	public CashFlowCalendar(BudgetItem budgetItem){
		cashFlowMonthList << new CashFlowMonth(budgetItem)
	}
	
	Double calcInitialBalance(Date currentDate){
		
		def ignoreAmount = 0
		def expenseList = PlannedTransaction.withCriteria{
			eq('plannedTransactionDate',currentDate)
			category{ eq('type','E') }
			projections{
				groupProperty('category.id')
				sum('amount')
			}
		}

		expenseList.each{
			def categoryId = it[0]
			def plannedTransactionTotal = it[1]
			def transactionList = Transaction.withCriteria{
				eq('transactionDate',currentDate)
				category{ eq('id',categoryId) }
				projections{ sum('amount') }
			}
			if(transactionList[0]){
				def transactionTotal = transactionList[0]
				if(plannedTransactionTotal <= Math.abs(transactionTotal)){
					ignoreAmount += plannedTransactionTotal
				}else{
					ignoreAmount -= transactionTotal
				}
			}
		}

		def incomeList = PlannedTransaction.withCriteria{
			eq('plannedTransactionDate',currentDate)
			category{ eq('type','I') }
			projections{
				groupProperty('category.id')
				sum('amount')
			}
		}

		incomeList.each{
			def categoryId = it[0]
			def plannedTransactionTotal = it[1]
			def transactionList = Transaction.withCriteria{
				eq('transactionDate',currentDate)
				category{ eq('id',categoryId) }
				projections{ sum('amount') }
			}
			if(transactionList[0]){
				def transactionTotal = transactionList[0]
				if(plannedTransactionTotal <= transactionTotal){
					ignoreAmount -= plannedTransactionTotal
				}else{
					ignoreAmount -= transactionTotal
				}
			}
		}
		
		Double balance = Account.calcSumByCash().list().get(0) + ignoreAmount
	}
	
	
}
