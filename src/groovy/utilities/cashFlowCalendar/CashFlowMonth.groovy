package utilities.cashFlowCalendar
import planning.PlannedTransaction
import planning.BudgetItem
import utilities.Utilities
class CashFlowMonth {
	Integer year
	Integer month
	Integer startDay
	List<CashFlowWeek> cashFlowWeekList = []
	
	public CashFlowMonth(Date startDate,Date endDate){
		def startDateDay = startDate.format('dd').toInteger()
		def endDateDay = endDate.format('dd').toInteger()
		def numberOfDays = endDateDay - startDateDay + 1
		this.year = startDate.format('yyyy').toInteger()
		this.month = startDate.format('MM').toInteger()
		this.startDay = calcStartDay(startDateDay)
		def incomeList = PlannedTransaction.findIncomeDailyTotalsByDateRange(startDate,endDate).list()
		def expenseList = PlannedTransaction.findExpenseDailyTotalsByDateRange(startDate,endDate).list()
		def daysInFirstWeek = 7-startDay
		numberOfDays -= daysInFirstWeek
		Integer numberOfFullWeeks = numberOfDays/7
		def daysInLastWeek = numberOfDays%7 
		cashFlowWeekList <<  new CashFlowWeek(incomeList,expenseList,startDateDay,daysInFirstWeek,false)
		startDateDay += daysInFirstWeek
		for(int i=0;i<numberOfFullWeeks;i++){
			cashFlowWeekList <<  new CashFlowWeek(incomeList,expenseList,startDateDay,7,false)
			startDateDay += 7
		}
		if(daysInLastWeek){
			cashFlowWeekList <<  new CashFlowWeek(incomeList,expenseList,startDateDay,daysInLastWeek,true)
		}
	}
	
	public CashFlowMonth(BudgetItem budgetItem){
		
		def dates = new Utilities().getBeginningAndEndOfMonth(budgetItem.year,budgetItem.month)
		def startDate = dates.firstOfMonth
		def endDate = dates.endOfMonth
		def startDateDay = 1
		def endDateDay = endDate.format('dd').toInteger()
		def numberOfDays = endDateDay - startDateDay + 1
		this.year = budgetItem.year
		this.month = budgetItem.month
		this.startDay = calcStartDay(startDateDay)
		def daysInFirstWeek = 7-startDay
		numberOfDays -= daysInFirstWeek
		Integer numberOfFullWeeks = numberOfDays/7
		def daysInLastWeek = numberOfDays%7
		def amountList = PlannedTransaction.findAllByDateRangeAndCategory(startDate,endDate,budgetItem.category).list()
		cashFlowWeekList <<  new CashFlowWeek(amountList,startDateDay,daysInFirstWeek)
		startDateDay += daysInFirstWeek
		for(int i=0;i<numberOfFullWeeks;i++){
			cashFlowWeekList <<  new CashFlowWeek(amountList,startDateDay,7)
			startDateDay += 7
		}
		if(daysInLastWeek){
			cashFlowWeekList <<  new CashFlowWeek(amountList,startDateDay,daysInLastWeek)
		}
	}
	
	Integer calcStartDay(Integer day){
		def calendar = Calendar.getInstance()
		calendar.set(this.year,this.month-1,day)
		return calendar.get(Calendar.DAY_OF_WEEK)-1
	}
	
}
