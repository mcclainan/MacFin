package category



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class MetaCategoryController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond MetaCategory.list(params), model:[metaCategoryInstanceCount: MetaCategory.count()]
    }

    def show(MetaCategory metaCategoryInstance) {
        respond metaCategoryInstance
    }

    def create() {
        respond new MetaCategory(params)
    }

    @Transactional
    def save(MetaCategory metaCategoryInstance) {
        if (metaCategoryInstance == null) {
            notFound()
            return
        }

        if (metaCategoryInstance.hasErrors()) {
            respond metaCategoryInstance.errors, view:'create'
            return
        }

        metaCategoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'metaCategoryInstance.label', default: 'MetaCategory'), metaCategoryInstance.id])
                redirect metaCategoryInstance
            }
            '*' { respond metaCategoryInstance, [status: CREATED] }
        }
    }

    def edit(MetaCategory metaCategoryInstance) {
        respond metaCategoryInstance
    }

    @Transactional
    def update(MetaCategory metaCategoryInstance) {
        if (metaCategoryInstance == null) {
            notFound()
            return
        }

        if (metaCategoryInstance.hasErrors()) {
            respond metaCategoryInstance.errors, view:'edit'
            return
        }

        metaCategoryInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'MetaCategory.label', default: 'MetaCategory'), metaCategoryInstance.id])
                redirect metaCategoryInstance
            }
            '*'{ respond metaCategoryInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(MetaCategory metaCategoryInstance) {

        if (metaCategoryInstance == null) {
            notFound()
            return
        }

        metaCategoryInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'MetaCategory.label', default: 'MetaCategory'), metaCategoryInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'metaCategoryInstance.label', default: 'MetaCategory'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
