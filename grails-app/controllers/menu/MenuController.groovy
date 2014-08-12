package menu
import utilities.cashFlowCalendar.CashFlowCalendar

class MenuController {
	def budgetComplianceService
    def index() {
		def budgetRemaining = budgetComplianceService.runReport()
		[cashFlowCalendar:new CashFlowCalendar(new Date().clearTime(),2),
		budgetRemaining:budgetRemaining]
	}
}
