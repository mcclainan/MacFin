package reports

class ReportController {
	def financialReportService
    def index() { 
		def year = params.year?:new Date().getAt(Calendar.YEAR)
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
}
