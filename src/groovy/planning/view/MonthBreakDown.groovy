package planning.view
import planning.BudgetItem
import utilities.Utilities
import tracking.Transaction
/**
 * @author tony
 * This class holds the month breakdown that shows the individual budget items for current
 * and future months and total transactions for given categories for past months
 * all sorted by category type (income or expense), then meta category then category
 */
class MonthBreakDown {
	Map incomeBreakdown = [:]
	Map expenseBreakdown = [:]
	Boolean actual = false
	/**
	 * @param month the 1 based month to retrieve the breakdown for
	 * @param year the year to retrieve the breakdown for
	 * @return 
	 * Creates a budgeted month breakdown from the planning package
	 */
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
	 * Creates an actual breakdown from the tracking package
	 */
	public MonthBreakDown(Integer month,Integer year, Boolean actual){
		Map dates = new Utilities().getBeginningAndEndOfMonth(year, month)
		Date startDate = dates.firstOfMonth
		Date endDate = dates.endOfMonth
		def query = "select m.name,c.name,sum(t.amount) " +
		  "from Transaction t, Category c, MetaCategory m " +
		  "where m.id = c.metaCategory and c.id = t.category " +
		  "and c.type in :type " +
		  "and t.transactionDate between :startDate and :endDate " +
		  "and m.name not in :excludedMetaCategories " +
		  "group by m.name,c.name " +
		  "order by m.name,c.name "
		def params = [type:['I'],startDate:startDate, endDate:endDate,excludedMetaCategories:["ADJUSTMENTS","UNTRACKED"]]
		def breakdown = Transaction.executeQuery(query,params)
		
		def tempMetaCategoryName = ""
		breakdown.each{
			def metaCategoryName = it[0]
			if(metaCategoryName != tempMetaCategoryName){
				incomeBreakdown."${metaCategoryName}" = []
				tempMetaCategoryName = metaCategoryName
			}
			incomeBreakdown."${metaCategoryName}" << [it[1], it[2]]
		}
		
		params.type = ['E']
		
		breakdown = Transaction.executeQuery(query,params)
		
		breakdown.each{
			def metaCategoryName = it[0]
			if(metaCategoryName != tempMetaCategoryName){
				expenseBreakdown."${metaCategoryName}" = []
				tempMetaCategoryName = metaCategoryName
			}
			expenseBreakdown."${metaCategoryName}" << [it[1], it[2]]
		}
		
		query = "select m.name,sum(t.amount) " +
				"from Transaction t, Category c, MetaCategory m " +
				"where m.id = c.metaCategory and c.id = t.category " +
				"and c.type in :type " +
				"and t.transactionDate between :startDate and :endDate " +
				"and m.name in :excludedMetaCategories " +
				"group by m.name " +
				"order by m.name "
		
		params.excludedMetaCategories = ["UNTRACKED"]
		params.type = ['E','I']
		def untrackedBreakDown = Transaction.executeQuery(query,params)
		def untrackedTotal = untrackedBreakDown.get[0][1]
		
		if(untrackedTotal > 0){
			incomeBreakdown."UNTRACKED"<<['Untracked Income',untrackedTotal]	
		}else if(untrackedTotal < 0){
			expenseBreakdown."UNTRACKED"<<['Untracked Expense',untrackedTotal]
		}
		
	}
}
