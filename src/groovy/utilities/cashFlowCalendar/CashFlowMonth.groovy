package utilities.cashFlowCalendar
import planning.PlannedTransaction

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
		def incomeList = PlannedTransaction.findIncomeDailyTotalsByDateRange(startDate,endDate).listOrderByPlannedTransactionDate()
		def expenseList = PlannedTransaction.findExpenseDailyTotalsByDateRange(startDate,endDate).listOrderByPlannedTransactionDate()
		def daysInFirstWeek = 7-startDay
		numberOfDays -= daysInFirstWeek
		Integer numberOfFullWeeks = numberOfDays/7
		def daysInLastWeek = numberOfDays%7 
		cashFlowWeekList <<  new CashFlowWeek(incomeList,expenseList,startDateDay,daysInFirstWeek)
		startDateDay += daysInFirstWeek
		for(int i=1;i<numberOfFullWeeks;i++){
			cashFlowWeekList <<  new CashFlowWeek(incomeList,expenseList,startDateDay,7)
			startDateDay += 7
		}
		if(daysInLastWeek){
			cashFlowWeekList <<  new CashFlowWeek(incomeList,expenseList,startDateDay,daysInLastWeek)
		}
	}
	Integer calcStartDay(){
		def calendar = Calendar.getInstance()
		calendar.set(year,month-1,1)
		startDay = calendar.get(Calendar.DAY_OF_WEEK)-1
	}
	
	Integer calcStartDay(Integer day){
		def calendar = Calendar.getInstance()
		calendar.set(this.year,this.month-1,day)
		return calendar.get(Calendar.DAY_OF_WEEK)-1
	}
	
}
