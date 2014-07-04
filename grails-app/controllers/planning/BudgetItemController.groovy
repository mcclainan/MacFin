package planning



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import utilities.cashFlowCalendar.CashFlowCalendar
import category.Category

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
		def startDate = new Date(month:budgetItemInstance.month-1)
		budgetItemInstance.calculateAmount()
		if((budgetItemInstance.month-1)!=new Date().getAt(Calendar.MONTH)){
			startDate.set(date:1)
		}
		
        respond budgetItemInstance, model:[cashFlowCalendar:new CashFlowCalendar(budgetItemInstance),startDate:startDate,visibility:'off']
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
	
	def change(){
		def budgetItemInstance = BudgetItem.findWhere(category:Category.get(params.category.id),month:params.month.toInteger(),year:params.year.toInteger())
		def id
		if(budgetItemInstance){
			id = budgetItemInstance.id
		}else{
			flash.message = "No Budget Item found for ${Category.get(params.category.id)} for ${params.month}/${params.year}"
			id = params.id
		}
		
		redirect(action:'show', id:id)
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
