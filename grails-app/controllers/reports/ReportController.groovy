package reports

class ReportController {
	def financialReportService
    def index() { 
		def year = params.year?:new Date().getAt(Calendar.YEAR)
//		[year:year]
		[report:financialReportService.getYearOverview(year),year:year]
	}
}
