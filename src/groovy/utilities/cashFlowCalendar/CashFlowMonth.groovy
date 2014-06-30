package utilities.cashFlowCalendar
import planning.PlannedTransaction
import planning.BudgetItem
import utilities.Utilities
class CashFlowMonth {
	Integer year
	Integer month
	Integer startDay
	Double balance
	List<CashFlowWeek> cashFlowWeekList = []
	
	public CashFlowMonth(Date startDate,Date endDate,Double balance){
		def startDateDay = startDate.format('dd').toInteger()
		def endDateDay = endDate.format('dd').toInteger()
		def numberOfDays = endDateDay - startDateDay + 1
		this.year = startDate.format('yyyy').toInteger()
		this.month = startDate.format('MM').toInteger()
		this.startDay = calcStartDay(startDateDay)
		def incomeList = PlannedTransaction.findIncomeDailyTotalsByDateRange(startDate,endDate).list()
		def expenseList = PlannedTransaction.findExpenseDailyTotalsByDateRange(startDate,endDate).list()
		def daysInFirstWeek = 7-startDay
		println "daysInFirstWeek ${daysInFirstWeek}"
		Boolean firstIsLast = false
		def offset = null
		if(numberOfDays<=7){
			daysInFirstWeek=numberOfDays
			offset = startDay
			firstIsLast=true
		}
		numberOfDays -= daysInFirstWeek
		Integer numberOfFullWeeks = numberOfDays/7
		def daysInLastWeek = numberOfDays%7 
		def week = new CashFlowWeek(incomeList,expenseList,startDateDay,daysInFirstWeek,firstIsLast,balance,offset)
		balance = week.balance
		cashFlowWeekList <<  week
		startDateDay += daysInFirstWeek
		for(int i=0;i<numberOfFullWeeks;i++){
			week = new CashFlowWeek(incomeList,expenseList,startDateDay,7,false,balance,offset)
			cashFlowWeekList <<  week
			balance = week.balance
			startDateDay += 7
		}
		if(daysInLastWeek){
			week = new CashFlowWeek(incomeList,expenseList,startDateDay,daysInLastWeek,true,balance,offset)
			balance = week.balance
			cashFlowWeekList <<  week
		}
		this.balance = balance
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
		cashFlowWeekList <<  new CashFlowWeek(amountList,startDateDay,daysInFirstWeek,false)
		startDateDay += daysInFirstWeek
		for(int i=0;i<numberOfFullWeeks;i++){
			cashFlowWeekList <<  new CashFlowWeek(amountList,startDateDay,7,false)
			startDateDay += 7
		}
		if(daysInLastWeek){
			cashFlowWeekList <<  new CashFlowWeek(amountList,startDateDay,daysInLastWeek,true)
		}
	}
	
	Integer calcStartDay(Integer day){
		def calendar = Calendar.getInstance()
		calendar.set(this.year,this.month-1,day)
		return calendar.get(Calendar.DAY_OF_WEEK)-1
	}
	
}
