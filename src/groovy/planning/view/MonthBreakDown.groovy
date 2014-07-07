package planning.view
import planning.BudgetItem
/**
 * @author tony
 * This class holds the month breakdown that shows the individual budget items for current
 * and future months and total transactions for given categories for past months
 * all sorted by category type (income or expense), then meta category then category
 */
class MonthBreakDown {
	Map incomeBreakdown = [:]
	Map expenseBreakdown = [:]

	public MonthBreakdown(Integer month, Integer year){
		def query = "select m.name,c.name,b.amount " +
				"from BudgetItem b, Category c, MetaCategory m " +
				"where m.id = c.metaCategory and c.id = b.category " +
				"and c.type = :type " +
				"and b.year = :year " +
				"and b.month = :month " +
				"order by m.name,c.name "
		def params = [type:'I',month:month, year:year]
		def breakdown = BudgetItem.executeQuery(query,params)

		def tempMetaCategoryName = ""
		breakdown.each{
			def metaCategoryName = it[0]
			if(metaCategoryName != tempMetaCategoryName){
				incomeBreakdown."${metaCategoryName}" = []
				tempMetaCategoryName = metaCategoryName
			}
			incomeBreakdown."${metaCategoryName}" << [it[1], it[2]]
		}
		
		params.type = 'E'
		breakdown = BudgetItem.executeQuery(query,params)
		tempMetaCategoryName = ""
		breakdown.each{
			def metaCategoryName = it[0]
			if(metaCategoryName != tempMetaCategoryName){
				expenseBreakdown."${metaCategoryName}" = []
				tempMetaCategoryName = metaCategoryName
			}
			expenseBreakdown."${metaCategoryName}" << [it[1], it[2]]
		}
	}
	
	/**
	 * @param month the 1 based month to retrieve the breakdown for
	 * @param year the year to retrieve the breakdown for
	 * @param actual a Boolean value to differentiate this constructor from the budgeted constructor
	 */
	public MonthBreakDown(Integer month,Integer year, Boolean actual){
		
	}
}
