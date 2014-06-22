package menu
import utilities.cashFlowCalendar.CashFlowCalendar

class MenuController {

    def index() {
		[cashFlowCalendar:new CashFlowCalendar(new Date().clearTime(),2)]
	}
}
