package utilities.cashFlowCalendar
import java.util.Date;
import planning.BudgetItem
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
		for(int i=1;i<numberOfMonths;i++){
			month++
			if(month>12){
				month = 1
				year++
			}
			def dates = new Utilities().getBeginningAndEndOfMonth(year, month)
			cashFlowMonthList<<new CashFlowMonth(dates.firstOfMonth,dates.endOfMonth)
		}
		cashFlowMonthList[0].cashFlowWeekList[0].cashFlowDayList.each{
			if(it.day == startDate.format('dd').toInteger()){
				it.isCurrentDay = true
				it.calcIgnoreAmount(startDate)
			}
		}
	}
	
	public CashFlowCalendar(BudgetItem budgetItem){
		cashFlowMonthList << new CashFlowMonth(budgetItem)
	}
}
