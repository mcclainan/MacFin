package utilities.cashFlowCalendar
import java.util.Date;
import utilities.Utilities

class CashFlowCalendar {
	Boolean forBudgetShow = false
	List<CashFlowMonth> cashFlowMonthList = []
	
	public CashFlowCalendar(Date startDate,Integer numberOfMonths){
		def year = startDate.format('yyyy').toInteger()
		def month = startDate.format('MM').toInteger()
		def endDate = Utilities.getEndOfMonth(year,month)
		def firstMonth = new CashFlowMonth(startDate,endDate)
		cashFlowMonthList<<firstMonth
		for(int i=0;i<numberOfMonths;i++){
			month++
			if(month>12){
				month = 1
				year++
			}
			def dates = new Utilities().getBeginningAndEndOfMonth(year, month)
			cashFlowMonthList<<new CashFlowMonth(dates.firstOfMonth,dates.endOfMonth)
		}
		CashFlowDay currentDay = cashFlowMonthList.get(0).cashFlowWeekList.get(0).cashFlowDayList(0)
		currentDay.isCurrentDay = true
		currentDay.calcCurrentTransactionAdjustment(startDate)
	}
}
