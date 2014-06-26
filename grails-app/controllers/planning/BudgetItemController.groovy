package planning



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import utilities.cashFlowCalendar.CashFlowCalendar

@Transactional(readOnly = true)
class BudgetItemController {  

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	def budgetItemService

    def index(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		respond BudgetItem.list(params), model:[budgetItemInstanceCount: BudgetItem.count()]
//		redirect(action:'view')
    }
	
	def view(Integer max){
		params.max = Math.min(max ?: 10, 100)
		respond BudgetItem.list(params), model:[budgetItemInstanceCount: BudgetItem.count()]
	}

    def show(BudgetItem budgetItemInstance) {
		def budgetItemInstanceList = BudgetItem.getAllByDateAndCategory(budgetItemInstance.category.id,budgetItemInstance.month,budgetItemInstance.year).list([max: 1, offset: 1])
		budgetItemInstanceList.each{
			println it
		}
        respond budgetItemInstance, model:[cashFlowCalendar:new CashFlowCalendar(budgetItemInstance),
										   budgetItemInstanceList:budgetItemInstanceList,
										   budgetItemInstanceCount:budgetItemInstanceList.getTotalCount()]
    }

    def create() {
		if(!params.month){
			params.month = new Date().format('MM').toInteger()
		}
		if(!params.year){
			params.year = new Date().format('yyyy').toInteger()
		}
        respond new BudgetItem(params)
    }

    @Transactional
    def save(BudgetItem budgetItemInstance) {
        if (budgetItemInstance == null) {
            notFound()
            return
        }

        if (budgetItemInstance.hasErrors()) {
            respond budgetItemInstance.errors, view:'create'
            return
        }

        def saveResults = budgetItemService.create(budgetItemInstance,params.numberOfMonths.toInteger())
		if(saveResults.class == BudgetItem.class){
			budgetItemInstance = saveResults
			respond budgetItemInstance.errors, view:'create'
			return
		}
        flash.message = message(code: 'budgetItem.created.message', args: [saveResults.size(),message(code: 'budgetItemInstance.label', default: 'BudgetItem')])
		redirect(action:'show',params:[id:saveResults.get(0).id])
    }

    def edit(BudgetItem budgetItemInstance) {
        respond budgetItemInstance
    }

    @Transactional
    def update(BudgetItem budgetItemInstance) {
        if (budgetItemInstance == null) {
            notFound()
            return
        }

        if (budgetItemInstance.hasErrors()) {
            respond budgetItemInstance.errors, view:'edit'
            return
        }

        budgetItemInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BudgetItem.label', default: 'BudgetItem'), budgetItemInstance.id])
                redirect budgetItemInstance
            }
            '*'{ respond budgetItemInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BudgetItem budgetItemInstance) {

        if (budgetItemInstance == null) {
            notFound()
            return
        }

        budgetItemInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BudgetItem.label', default: 'BudgetItem'), budgetItemInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'budgetItemInstance.label', default: 'BudgetItem'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
