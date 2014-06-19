package utilities.cashFlowCalendar

class CashFlowCalendar {
	Integer numberOfMonths
	Date startDate
	List<CashFlowMonth> cashFlowMonthList = []
	
	def calcStartDays(){
		cashFlowMonthList.get(0).calcStartDay(startDate)
		for(int i=1;i<cashFlowMonthList.size();i++){
			cashFlowMonthList.get(i).calcStartDay()
		}
	}
	
	
}
