package utilities.cashFlowCalendar

import planning.PlannedTransaction

class CashFlowWeek {
	List<CashFlowDay> cashFlowDayList
	
	public CashFlowWeek(List incomeList, List expenseList, Integer startDate, Integer numberOfDays){
		for(int i=0;i<numberOfDays;i++){
			def cashFlowDay = new CashFlowDay(day:startDate)
			if(incomeList.get(0).get(0).format('dd') == startDate){
				cashFlowDay.income = incomeList.get(0).get(1)
				incomeList.remove(0)
			}
			if(expenseList.get(0).get(0).format('dd') == startDate){
				cashFlowDay.expense = expenseList.get(0).get(1)
				expenseList.remove(0)
			}
			startDate++
			cashFlowDayList<<cashFlowDay
		}
	}
	public CashFlowWeek(List amountList, Integer startDate, Integer numberOfDays){
		for(int i=0;i<numberOfDays;i++){
			def cashFlowDay = new CashFlowDay(day:startDate)
			if(amountList.get(0).get(0).format('dd') == startDate){
				cashFlowDay.amount = amountList.get(0).get(1)
				amountList.remove(0)
			}
			cashFlowDayList<<cashFlowDay
		}
	}
}
