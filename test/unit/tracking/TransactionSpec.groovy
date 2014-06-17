package tracking

import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Transaction)
class TransactionSpec extends Specification {
	def transaction
    
	void "test valid transaction constraints"() {
		when:"Transaction is valid"
		then:"Transaction should validate"
			transaction.validate()
	}
	
	void "test category constraints"() {
	
	}
	
	def setup() {
		transaction = new Transaction(category: new category.Category(), 
			                          name:'Name', 
									  amount: 100, 
									  account:new Account())
    }

    def cleanup() {
    }
}
