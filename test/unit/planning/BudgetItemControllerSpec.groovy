package planning



import grails.test.mixin.*
import spock.lang.*

@TestFor(BudgetItemController)
@Mock(BudgetItem)
class BudgetItemControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action redirects to the view action"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            response.redirectedUrl == '/budgetItem/view'
    }
	
	void "Test the create action returns the correct model"(){
		when:"The create action is called"
			controller.create()
		then:"The budget item instance, year, and month are in the model year and month are integers"
			model.budgetItemInstance
			model.budgetItemInstance.year == new Date().format('yyyy').toInteger()
			model.budgetItemInstance.month == new Date().format('MM').toInteger()
			
		when:"The create action is called with month and year on the params"
			params.month = 1
			params.year = 2000
			controller.create()
		then:"The month and year reflect the parameters sent"
			model.budgetItemInstance.year == 2000
			model.budgetItemInstance.month == 1
	}
//
//    void "Test the create action returns the correct model"() {
//        when:"The create action is executed"
//            controller.create()
//
//        then:"The model is correctly created"
//            model.budgetItemInstance!= null
//    }
//
//    void "Test the save action correctly persists an instance"() {
//
//        when:"The save action is executed with an invalid instance"
//            request.contentType = FORM_CONTENT_TYPE
//            def budgetItem = new BudgetItem()
//            budgetItem.validate()
//            controller.save(budgetItem)
//
//        then:"The create view is rendered again with the correct model"
//            model.budgetItemInstance!= null
//            view == 'create'
//
//        when:"The save action is executed with a valid instance"
//            response.reset()
//            populateValidParams(params)
//            budgetItem = new BudgetItem(params)
//
//            controller.save(budgetItem)
//
//        then:"A redirect is issued to the show action"
//            response.redirectedUrl == '/budgetItem/show/1'
//            controller.flash.message != null
//            BudgetItem.count() == 1
//    }
//
//    void "Test that the show action returns the correct model"() {
//        when:"The show action is executed with a null domain"
//            controller.show(null)
//
//        then:"A 404 error is returned"
//            response.status == 404
//
//        when:"A domain instance is passed to the show action"
//            populateValidParams(params)
//            def budgetItem = new BudgetItem(params)
//            controller.show(budgetItem)
//
//        then:"A model is populated containing the domain instance"
//            model.budgetItemInstance == budgetItem
//    }
//
//    void "Test that the edit action returns the correct model"() {
//        when:"The edit action is executed with a null domain"
//            controller.edit(null)
//
//        then:"A 404 error is returned"
//            response.status == 404
//
//        when:"A domain instance is passed to the edit action"
//            populateValidParams(params)
//            def budgetItem = new BudgetItem(params)
//            controller.edit(budgetItem)
//
//        then:"A model is populated containing the domain instance"
//            model.budgetItemInstance == budgetItem
//    }
//
//    void "Test the update action performs an update on a valid domain instance"() {
//        when:"Update is called for a domain instance that doesn't exist"
//            request.contentType = FORM_CONTENT_TYPE
//            controller.update(null)
//
//        then:"A 404 error is returned"
//            response.redirectedUrl == '/budgetItem/index'
//            flash.message != null
//
//
//        when:"An invalid domain instance is passed to the update action"
//            response.reset()
//            def budgetItem = new BudgetItem()
//            budgetItem.validate()
//            controller.update(budgetItem)
//
//        then:"The edit view is rendered again with the invalid instance"
//            view == 'edit'
//            model.budgetItemInstance == budgetItem
//
//        when:"A valid domain instance is passed to the update action"
//            response.reset()
//            populateValidParams(params)
//            budgetItem = new BudgetItem(params).save(flush: true)
//            controller.update(budgetItem)
//
//        then:"A redirect is issues to the show action"
//            response.redirectedUrl == "/budgetItem/show/$budgetItem.id"
//            flash.message != null
//    }
//
//    void "Test that the delete action deletes an instance if it exists"() {
//        when:"The delete action is called for a null instance"
//            request.contentType = FORM_CONTENT_TYPE
//            controller.delete(null)
//
//        then:"A 404 is returned"
//            response.redirectedUrl == '/budgetItem/index'
//            flash.message != null
//
//        when:"A domain instance is created"
//            response.reset()
//            populateValidParams(params)
//            def budgetItem = new BudgetItem(params).save(flush: true)
//
//        then:"It exists"
//            BudgetItem.count() == 1
//
//        when:"The domain instance is passed to the delete action"
//            controller.delete(budgetItem)
//
//        then:"The instance is deleted"
//            BudgetItem.count() == 0
//            response.redirectedUrl == '/budgetItem/index'
//            flash.message != null
//    }
}
