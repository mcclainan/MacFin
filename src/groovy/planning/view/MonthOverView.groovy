package planning.view
import planning.BudgetItem
import tracking.Transaction
import utilities.Utilities
/**
 * @author tony
 * This class holds the overall total income and expense for a given month
 * and calculates the ending total for that month
 */
class MonthOverView {
	Integer month
	Double incomeTotal
	Double expenseTotal
	Double endingTotal
	
	
	/**
	 * @param month the 1 based month to be retrieve information for
	 * @param year the year to be retrieve information for
	 * This constructor takes a month and year then uses it to find the budgeted totals
	 * for the given month applying any untracked amounts to appropriate totals based on 
	 * the amount it's self
	 */
	public MonthOverView(Integer month,Integer year){
		this.month = month
		def incomeQueryTotal = BudgetItem.withCriteria{
			eq("year",year)
			eq("month", month)
			category{
				eq("type","I")
				metaCategory{
					not{'in'("name",["ADJUSTMENTS","UNTRACKED"])}
				}
			}
			projections{
				sum("amount")
			}
		}
		incomeTotal = incomeQueryTotal[0] ?:0
		
		def expenseQueryTotal = BudgetItem.withCriteria{
			eq("year",year)
			eq("month", month)
			category{
				eq("type","E")
				metaCategory{
					not{'in'("name",["ADJUSTMENTS","UNTRACKED"])}
				}
			}
			projections{
				sum("amount")
			}
		}
		
		expenseTotal = expenseQueryTotal[0] ?:0
		def untrackedQueryTotal = BudgetItem.withCriteria{
			eq("year",year)
			eq("month", month)
			category{
				metaCategory{
					eq("name","UNTRACKED")
				}
			}
			projections{
				sum("amount")
			}
		}
		
		
		def untrackedTotal =  untrackedQueryTotal[0]?:0
		if(untrackedTotal > 0){
			incomeTotal += untrackedTotal
		}else{
			expenseTotal += untrackedTotal
		}
	}
	
	/**
	 * @param month the 1 based month to be retrieve information for
	 * @param year the year to be retrieve information for
	 * @param actual populated so that this method is fired for actual amounts
	 */
	public MonthOverView(Integer month,Integer year,Boolean actual){
		this.month = month
		Map dates = new Utilities().getBeginningAndEndOfMonth(year, month)
		Date firstOfMonth = dates.firstOfMonth
		Date endOfMonth = dates.endOfMonth
		
		def incomeQueryTotal = Transaction.withCriteria {
			between("transactionDate",firstOfMonth,endOfMonth)
			category{
				eq("type","I")
				metaCategory{
					not{'in'("name",["ADJUSTMENTS","UNTRACKED"])}
				}
			}
			projections{
				sum("amount")
			}
		}
		incomeTotal = incomeQueryTotal[0]?:0
		
		def expenseQueryTotal = Transaction.withCriteria {
			between("transactionDate",firstOfMonth,endOfMonth)
			category{
				eq("type","E")
				metaCategory{
					not{'in'("name",["ADJUSTMENTS","UNTRACKED"])}
				}
			}
			projections{
				sum("amount")
			}
		}
		expenseTotal = expenseQueryTotal[0]?:0
		
		def untrackedQueryTotal = Transaction.withCriteria {
			between("transactionDate",firstOfMonth,endOfMonth)
			category{
				metaCategory{
					eq("name","UNTRACKED")
				}
			}
			projections{
				sum("amount")
			}
		}
		def untrackedTotal = untrackedQueryTotal[0]?:0
		
		if(untrackedTotal > 0){
			incomeTotal += untrackedTotal
		}else{
			expenseTotal += untrackedTotal
		}
	}
	
	/**
	 * @param currentResources
	 * @return Double
	 * Takes in the current resources and calculates a new one based on the objects current properties
	 */
	Double calculatEendingTotal(Double currentResources){
		endingTotal = currentResources + incomeTotal - Math.abs(expenseTotal)
	}
}
