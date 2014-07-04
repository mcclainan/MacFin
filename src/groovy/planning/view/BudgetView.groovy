package planning.view

import planning.YearBeginningResources

/**
 * @author tony
 * A class that will elegantly deliver a snapshot of the current budget to the GSP
 */
class BudgetView {
	
	List<MonthTotal> yearOverview = []
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
	}
}


