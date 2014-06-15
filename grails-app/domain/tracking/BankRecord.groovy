package tracking

import java.util.Date;
import tracking.Account;
import tracking.Transaction;

class BankRecord {
	Date transactionDate
	Date created = new Date().clearTime()
	Account account
	String description
	Double amount
	Transaction transaction
	
	
    static constraints = {
		account blank:false
		transactionDate blank:false
		description blank:false,  unique : ["transactionDate", "amount"]
		amount blank:false
		transaction nullable:true
		created nullable:true
    }
}
