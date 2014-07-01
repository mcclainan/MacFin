package planning



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import utilities.cashFlowCalendar.CashFlowCalendar

@Transactional(readOnly = true)
class PlannedTransactionController {
	def plannedTransactionService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PlannedTransaction.list(params), model:[plannedTransactionInstanceCount: PlannedTransaction.count()]
    }

    def show(PlannedTransaction plannedTransactionInstance) {
        respond plannedTransactionInstance
    }

    def create() {
        respond new PlannedTransaction(params)
    }

    @Transactional
    def save(PlannedTransactionCommand cmd) {
        params.each{
			println it
		}
		if(cmd.hasErrors()){
			cmd.errors.each{
				println it
			}
			render view:'/budgetItem/show',model:[budgetItemInstance:cmd.budgetItem,
												 cashFlowCalendar:new CashFlowCalendar(cmd.budgetItem),
												 plannedTransactionCommand:cmd]
			return
		}
		flash.messages = plannedTransactionService.create(cmd)
		request.withFormat {
			form multipartForm {
				redirect controller:'budgetItem',action:"show", method:"GET", id:params.budgetItemId
			}
			'*'{ render status: OK }
		}
    }

    def edit(PlannedTransaction plannedTransactionInstance) {
        respond plannedTransactionInstance
    }

    @Transactional
    def update(PlannedTransaction plannedTransactionInstance) {
        if (plannedTransactionInstance == null) {
            notFound()
            return
        }

        if (plannedTransactionInstance.hasErrors()) {
            respond plannedTransactionInstance.errors, view:'edit'
            return
        }

        plannedTransactionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PlannedTransaction.label', default: 'PlannedTransaction'), plannedTransactionInstance.id])
                redirect plannedTransactionInstance
            }
            '*'{ respond plannedTransactionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PlannedTransaction plannedTransactionInstance) {

        if (plannedTransactionInstance == null) {
            notFound()
            return
        }

        plannedTransactionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PlannedTransaction.label', default: 'PlannedTransaction'), plannedTransactionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'plannedTransactionInstance.label', default: 'PlannedTransaction'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
