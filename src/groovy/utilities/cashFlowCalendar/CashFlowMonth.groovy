package utilities.cashFlowCalendar

class CashFlowMonth {
	Integer year
	Integer month
	Integer startDay
	List<CashFlowWeek> cashFlowWeekList
	
	Integer calcStartDay(){
		def calendar = Calendar.getInstance()
		calendar.set(year,month-1,1)
		startDay = calendar.get(Calendar.DAY_OF_WEEK)-1
	}
	
	void calcStartDay(Date startDate){
		def day
		if(startDate){
			year = startDate.format('yyyy').toInteger()
			month = startDate.format('MM').toInteger()
			day = startDate.format('dd').toInteger()
		}else{
			day = 1
		}
		def calendar = Calendar.getInstance()
		calendar.set(year,month-1,day)
		startDay = calendar.get(Calendar.DAY_OF_WEEK)-1
	}
	
}
