package utilities.cashFlowCalendar

import planning.PlannedTransaction

class CashFlowWeek {
	List<CashFlowDay> cashFlowDayList = []
	Double balance = 0
	
	public CashFlowWeek(List incomeList, List expenseList, Integer startDate, Integer numberOfDays, Boolean isLastWeek,Double balance, Integer firstIsLastOffset){
		if(!isLastWeek){
			for(int i=0;i<(7-numberOfDays);i++){
				cashFlowDayList<<new CashFlowDay()
			}
		}else if(firstIsLastOffset){
			for(int i=0;i<firstIsLastOffset;i++){
				cashFlowDayList<<new CashFlowDay()
			}
		}
		
		for(int i=0;i<numberOfDays;i++){
			def cashFlowDay = new CashFlowDay(day:startDate,balance:balance)
			if(incomeList){
				if(incomeList[0][0].format('dd').toInteger() == startDate){
					cashFlowDay.income = incomeList[0][1]
							incomeList.remove(0)
				}
			}
			if(expenseList){
				if(expenseList[0][0].format('dd').toInteger() == startDate){
					cashFlowDay.expense = expenseList[0][1]
							expenseList.remove(0)
				}
			}
			startDate++
			cashFlowDayList<<cashFlowDay
			balance = cashFlowDay.calcBalance()
		}
		this.balance = balance
	}
	public CashFlowWeek(List amountList, Integer startDate, Integer numberOfDays,Boolean isLastWeek){
		if(!isLastWeek){
			for(int i=0;i<(7-numberOfDays);i++){
				cashFlowDayList<<new CashFlowDay()
			}
		}
		for(int i=0;i<numberOfDays;i++){
			def cashFlowDay = new CashFlowDay()
			cashFlowDay.day = startDate
			if(amountList){
				if(amountList[0][0].format('dd').toInteger() == startDate){
					cashFlowDay.amount = amountList[0][1]
					amountList.remove(0)
				}
			}
			startDate++
			cashFlowDayList<<cashFlowDay
		}
	}
}
