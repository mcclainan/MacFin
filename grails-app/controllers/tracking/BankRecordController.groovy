package tracking



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import java.text.ParseException
import java.text.SimpleDateFormat

@Transactional(readOnly = true)
class BankRecordController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	def bankRecordService
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond BankRecord.list(params), model:[bankRecordInstanceCount: BankRecord.count()]
    }

    def show(BankRecord bankRecordInstance) {
        respond bankRecordInstance
    }

    def create() {
        respond new BankRecord(params)
    }

    @Transactional
    def save(BankRecord bankRecordInstance) {
        if (bankRecordInstance == null) {
            notFound()
            return
        }

        if (bankRecordInstance.hasErrors()) {
            respond bankRecordInstance.errors, view:'create'
            return
        }

        bankRecordInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'bankRecordInstance.label', default: 'BankRecord'), bankRecordInstance.id])
                redirect bankRecordInstance
            }
            '*' { respond bankRecordInstance, [status: CREATED] }
        }
    }

    def edit(BankRecord bankRecordInstance) {
        respond bankRecordInstance
    }

    @Transactional
    def update(BankRecord bankRecordInstance) {
        if (bankRecordInstance == null) {
            notFound()
            return
        }

        if (bankRecordInstance.hasErrors()) {
            respond bankRecordInstance.errors, view:'edit'
            return
        }

        bankRecordInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'BankRecord.label', default: 'BankRecord'), bankRecordInstance.id])
                redirect bankRecordInstance
            }
            '*'{ respond bankRecordInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(BankRecord bankRecordInstance) {

        if (bankRecordInstance == null) {
            notFound()
            return
        }

        bankRecordInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'BankRecord.label', default: 'BankRecord'), bankRecordInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
	
	def loadFile(){
		//Pass through to view
	}
	
	@Transactional
	def upload(){
		
		Account account = Account.get(params.account.id)
		
		if(!account){
			notFound('Account',"id ${params.account.id}")
		}else if(!account.bank){
			notFound('loadFile','Bank',"${account} account")
		}
		def serviceResults = bankRecordService.upload(request,flash,account)
		
		if(!flash.errors){
			flash.message = "${bankRecordsList.size()} Bank Records where added. The file contained ${duplicateBankRecordsList.size()} duplicate records."
			[bankRecordsList:serviceResults.bankRecordsList,duplicateBankRecordsList:serviceResults.duplicateBankRecordsList]
		}else{
			redirect action:'loadFile'
		}
	}
	
	def errorAction(){
		def elementNumbers = []
		def amountElements = []
		def elementNumber = 0
		flash.errors.each{
			println it
		}
		session.newFile.get(0).each{
			elementNumbers << elementNumber
			amountElements << elementNumber++
		}
		amountElements<<"multiple"
		render(view:"configureUpload", model:[elementNumbers:elementNumbers,amountElements:amountElements])
	}

    protected void notFound(String redirectView,String object,String addendum) {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'bankRecordController.not.found.message', args: [object, addendum])
                redirect action: redirectView?:"index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
