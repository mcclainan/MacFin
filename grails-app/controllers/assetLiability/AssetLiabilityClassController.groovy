package assetLiability



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AssetLiabilityClassController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AssetLiabilityClass.list(params), model:[assetLiabilityClassInstanceCount: AssetLiabilityClass.count()]
    }

    def show(AssetLiabilityClass assetLiabilityClassInstance) {
        respond assetLiabilityClassInstance
    }

    def create() {
        respond new AssetLiabilityClass(params)
    }

    @Transactional
    def save(AssetLiabilityClass assetLiabilityClassInstance) {
        if (assetLiabilityClassInstance == null) {
            notFound()
            return
        }

        if (assetLiabilityClassInstance.hasErrors()) {
            respond assetLiabilityClassInstance.errors, view:'create'
            return
        }

        assetLiabilityClassInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'assetLiabilityClassInstance.label', default: 'AssetLiabilityClass'), assetLiabilityClassInstance.id])
                redirect assetLiabilityClassInstance
            }
            '*' { respond assetLiabilityClassInstance, [status: CREATED] }
        }
    }

    def edit(AssetLiabilityClass assetLiabilityClassInstance) {
        respond assetLiabilityClassInstance
    }

    @Transactional
    def update(AssetLiabilityClass assetLiabilityClassInstance) {
        if (assetLiabilityClassInstance == null) {
            notFound()
            return
        }

        if (assetLiabilityClassInstance.hasErrors()) {
            respond assetLiabilityClassInstance.errors, view:'edit'
            return
        }

        assetLiabilityClassInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AssetLiabilityClass.label', default: 'AssetLiabilityClass'), assetLiabilityClassInstance.id])
                redirect assetLiabilityClassInstance
            }
            '*'{ respond assetLiabilityClassInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AssetLiabilityClass assetLiabilityClassInstance) {

        if (assetLiabilityClassInstance == null) {
            notFound()
            return
        }

        assetLiabilityClassInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AssetLiabilityClass.label', default: 'AssetLiabilityClass'), assetLiabilityClassInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'assetLiabilityClassInstance.label', default: 'AssetLiabilityClass'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
