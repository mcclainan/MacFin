package planning.view

import planning.YearBeginningResources

/**
 * @author tony
 * A class that will elegantly deliver a snapshot of the current budget to the GSP
 */
class BudgetView {
	
	List<MonthTotal> yearOverview = []
	MonthBreakDown monthBreakdown 
	/**
	 * @param params A map that must contain a month and year or else the month and year defaults to the current month and year
	 */
	public BudgetView(Map params){
		def year = (params.year?:new Date().format("yyyy")).toInteger()
		def month = (params.month?:new Date().format("MM")).toInteger()
		YearBeginningResources yBR = YearBeginningResources.findByYear(year.toInteger())
		double totalResorces = yBR.actualCash + yBR.actualCreditCard + yBR.actualBenifits + yBR.actualOther
		for(int i = 1; i <= 12; i++){
			if(i < new Date().format("MM").toInteger() && params.staticBudget != true ){
				def monthTotal = new MonthTotal(i,year)
				totalResorces = monthTotal.calculatEendingTotal(totalResorces)
				yearOverview << monthTotal
			}else{
				def monthTotal = new MonthTotal(i,year,true)
				totalResorces = monthTotal.calculatEendingTotal(totalResorces)
				yearOverview << monthTotal
			}		
					
		}
		
		Date cutOffDate = new Date(date:1,month:month-1)
		cutOffDate.set(year:year)
		if(new Date().clearTime()>=cutOffDate.clearTime()){
			monthBreakdown = new MonthBreakDown(month, year)
		}else{
			monthBreakdown = new MonthBreakDown(month, year,true)
		}
	}
}


