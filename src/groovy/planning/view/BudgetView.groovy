package planning.view

import planning.YearBeginningResources

/**
 * @author tony
 * A class that will elegantly deliver a snapshot of the current budget to the GSP
 */
class BudgetView {
	Integer year
	Integer month
	List<MonthOverView> yearOverview = []
	MonthBreakDown monthBreakdown 
	/**
	 * @param params A map that must contain a month and year or else the month and year defaults to the current month and year
	 */
	public BudgetView(Map params){
		year = (params.year?:new Date().format("yyyy")).toInteger()
		month = (params.month?:new Date().format("MM")).toInteger()
		YearBeginningResources yBR = YearBeginningResources.findByYear(year)
		double totalResorces = yBR.actualCash + yBR.actualCreditCard + yBR.actualBenifits + yBR.actualOther
		for(int i = 1; i <= 12; i++){
			if(i <= new Date().getAt(Calendar.MONTH)){
				def monthOverView = new MonthOverView(i,year,true)
				totalResorces = monthOverView.calculatEendingTotal(totalResorces)
				yearOverview << monthOverView
			}else{
				def monthOverView = new MonthOverView(i,year)
				totalResorces = monthOverView.calculatEendingTotal(totalResorces)
				yearOverview << monthOverView
			}		
					
		}
		
		Date budgetDate = new Date(date:1,month:month-1)
		budgetDate.set(year:year)
		Date firstOfCurrentMonth = new Date(date:1)
		if(firstOfCurrentMonth.clearTime()<=budgetDate.clearTime()){
			monthBreakdown = new MonthBreakDown(month, year)
		}else{
			monthBreakdown = new MonthBreakDown(month, year,true)
		}
	}
}


