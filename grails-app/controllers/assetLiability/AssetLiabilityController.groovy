package assetLiability



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AssetLiabilityController {
	def assetLiabilityService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AssetLiability.list(params), model:[assetLiabilityInstanceCount: AssetLiability.count()]
    }

    def show(AssetLiability assetLiabilityInstance) {
        respond assetLiabilityInstance
    }

    def create() {
        respond new AssetLiability(params)
    }

    @Transactional
    def save(AssetLiability assetLiabilityInstance) {
        if (assetLiabilityInstance == null) {
            notFound()
            return
        }

        assetLiabilityService.create(assetLiabilityInstance)

		if (assetLiabilityInstance.hasErrors()) {
            respond assetLiabilityInstance.errors, view:'create'
            return
        }
			
        assetLiabilityInstance.save flush:true
		
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'assetLiabilityInstance.label', default: 'AssetLiability'), assetLiabilityInstance.id])
                redirect assetLiabilityInstance
            }
            '*' { respond assetLiabilityInstance, [status: CREATED] }
        }
    }

    def edit(AssetLiability assetLiabilityInstance) {
        respond assetLiabilityInstance
    }

    @Transactional
    def update(AssetLiability assetLiabilityInstance) {
        if (assetLiabilityInstance == null) {
            notFound()
            return
        }

        if (assetLiabilityInstance.hasErrors()) {
            respond assetLiabilityInstance.errors, view:'edit'
            return
        }

        assetLiabilityInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AssetLiability.label', default: 'AssetLiability'), assetLiabilityInstance.id])
                redirect assetLiabilityInstance
            }
            '*'{ respond assetLiabilityInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AssetLiability assetLiabilityInstance) {

        if (assetLiabilityInstance == null) {
            notFound()
            return
        }

        assetLiabilityInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AssetLiability.label', default: 'AssetLiability'), assetLiabilityInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'assetLiabilityInstance.label', default: 'AssetLiability'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
