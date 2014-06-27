package planning



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PlannedTransactionController {

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
    def save(PlannedTransaction plannedTransactionInstance) {
        if (plannedTransactionInstance == null) {
            notFound()
            return
        }

        if (plannedTransactionInstance.hasErrors()) {
            respond plannedTransactionInstance.errors, view:'create'
            return
        }

        plannedTransactionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'plannedTransactionInstance.label', default: 'PlannedTransaction'), plannedTransactionInstance.id])
                redirect plannedTransactionInstance
            }
            '*' { respond plannedTransactionInstance, [status: CREATED] }
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
