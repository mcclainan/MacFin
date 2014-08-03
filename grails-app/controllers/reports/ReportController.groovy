package reports
import tracking.Transaction
import utilities.Utilities
import category.Category

class ReportController {
	def financialReportService
    def index() { 
		def year = params.year?.toInteger()?:new Date().getAt(Calendar.YEAR)
//		[year:year]
		[report:financialReportService.getYearOverview(year),year:year]
	}
	
	def monthFinancial(Integer month, Integer year){
		def report = financialReportService.getMonthBreakdown(month?:new Date().getAt(Calendar.MONTH)+1, year?:new Date().getAt(Calendar.YEAR))
		[month:month?:new Date().getAt(Calendar.MONTH)+1,
		 year: year?:new Date().getAt(Calendar.YEAR),
		 incomeBreakdown:report.incomeBreakdown,
		 expenseBreakdown:report.expenseBreakdown]
	}
	
	def categoryForMonth(Integer month, Integer year,String categoryName){
		def dates = new Utilities().getBeginningAndEndOfMonth(year, month)
		println dates
		def c = Transaction.createCriteria()
		def transactionInstanceList = c.list(max: 10, offset: params.offset?:0){
			between('transactionDate',dates.firstOfMonth,dates.endOfMonth)
			eq('category',Category.findByName(categoryName.trim()))
			order('transactionDate','asc') 
		}
		
		[transactionInstanceList:transactionInstanceList,transactionInstanceCount:transactionInstanceList.getTotalCount(),month:month, year:year,categoryName:categoryName]
	}
}
