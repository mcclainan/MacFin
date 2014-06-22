package utilities.cashFlowCalendar
import planning.PlannedTransaction
import tracking.Transaction
class CashFlowDay {
	Integer day = 0
	Double income = 0
	Double expense = 0
	Double amount = 0
	Double ignoreAmount = 0
	Boolean isCurrentDay = false

	void calcIgnoreAmount(Date currentDate){
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
	}
}
