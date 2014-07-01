package planning
import category.Category
import tracking.Account
import tracking.Transaction

class PlannedTransactionService {

	Date currentDate 
   
	def createSet(PlannedTransactionCommand cmd) {
/*Create Local Variables*/
		//Retrieve initial budget item
		BudgetItem budgetItem = cmd.budgetItem
		//Create map to hold errors
		Map errors = [:]
		//Create variable to count the errors to make unique error keys on the error map
		Integer errorIterator = 1
		//Create map to hold messages
		Map messages = [:]
		//Create variable to count the messages to make unique message keys on the message map
		Integer messageIterator = 1
		//Create a lists for planned transactions
		List plannedTransactions = []
		List newPlannedTransactions = []
		//????
		Double amount = 0
		//Category that all planned transactions will have
		Category categoryInstance = cmd.budgetItem.category
		//Initiate current date global variable
		currentDate = new Date()
/*End Variable Creation*/
	

		
		//If the user chooses to replace current set the delete all planned transactions in the date range
		if(cmd.replaceCurrentSet){
			List currentSet = PlannedTransaction.withCriteria {
				between("plannedTransactionDate",cmd.startDate-1,cmd.endDate+1)
				category{
					eq("id",categoryInstance.id)
				}
			}		
			currentSet.each{ plannedTransaction ->
				plannedTransaction.delete(flush:true)
			}
		}
		
		
		currentDate = cmd.startDate
		
		if(cmd.createMode == "single"){
			PlannedTransaction plannedTransaction = new PlannedTransaction(plannedTransactionDate:currentDate.clearTime(),category:categoryInstance, budgetItem:budgetItem, amount:params.amount)
			plannedTransaction.save(flush:true)
			budgetItem.calculateAmount()
			messages."message${messageIterator++}" = "1 planned transaction created for ${budgetItem}"
		}else{
			int i = 1
			while(currentDate <= cmd.endDate){
				Integer year = currentDate.format("yyyy").toInteger()
				Integer month = currentDate.format("MM").toInteger() 
				if(budgetItem.year != year || budgetItem.month != month){
					List budgetItems = BudgetItem.withCriteria {
						eq("year",year)
						eq("month",month)
						category{
							eq("id",categoryInstance.id)
						}
					}
					
					if(budgetItems){
						budgetItem = budgetItems.get(0)
					}else{
						budgetItem = new BudgetItem(year:year,
													month:month,
													category:cmd.budgetItem.category,
													cash:cmd.budgetItem.cash,
													required:cmd.budgetItem.required)
						budgetItem.save()
					}
				}
				
				PlannedTransaction plannedTransaction = new PlannedTransaction(plannedTransactionDate:currentDate.clearTime(),
																			   category:categoryInstance, 
																			   budgetItem:budgetItem,
																			   rolling:budgetItem.required)
				plannedTransaction.save()
				
				plannedTransactions << plannedTransaction
				
				getNextDate(cmd.frequencyOption)
				
				if(budgetItem.year != currentDate.format("yyyy").toInteger() || budgetItem.month != currentDate.format("MM").toInteger()){
					messages."message${messageIterator++}" = "${plannedTransactions.size()} planned transaction created for ${budgetItem}"
					
					if(cmd.amountOption == "deriveAmount"){
						amount = budgetItem.amount/plannedTransactions.size()
					}
					
					plannedTransactions.each{
						it.amount = amount
						it.save()
					}
					
					budgetItem.calculateAmount()
					plannedTransactions = []
				}
			}
		}
		
		return messages
	}

	def getNextDate(String frequencyOption){
		if(frequencyOption == "daily"){
			currentDate = currentDate + 1
		}else if(frequencyOption == "biDaily"){
			currentDate = currentDate + 2
		}else if(frequencyOption == "weekly"){
			currentDate = currentDate + 7
		}else if(frequencyOption == "biWeekly"){
			currentDate = currentDate + 14
		}else if(frequencyOption == "monthly"){
			Calendar calendar = new GregorianCalendar(currentDate.format("YYYY").toInteger(), currentDate.format("MM").toInteger()-1, currentDate.format("dd").toInteger())
			calendar.add(Calendar.MONTH, 1)
			int month = calendar.get(Calendar.MONTH)
			if(month == 0){
				currentDate.set(year:currentDate.format("YYYY").toInteger()+1)
			}
			currentDate.set(month:month)
		}//else if(frequencyOption == "semiMonthly"){
		//		}
	}
	
	def getSearchDateRange(Map params){
		Date startDate
		Date endDate
		
		def month = params.month.format("MM").toInteger()
		def year = params.month.format("yyyy").toInteger()
		
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month, 1);
		int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		def firstOfTheMonth = new Date()
		firstOfTheMonth.set(year: year, month: month-1, date:1)
		def endOfTheMonth = new Date()
		endOfTheMonth.set(year: year, month: month-1, date:days)
		
		[startDate:firstOfTheMonth.clearTime(),endDate:endOfTheMonth.clearTime()]
	}
	
	def editAmount(PlannedTransaction plannedTransaction, Map params){
		def errors = [:]
		def amount
		try{
			amount = params.amount.toDouble()
			if(amount < 0) throw new NumberFormatException()
			plannedTransaction.amount = amount
			plannedTransaction.budgetItem.calculateAmount()
		}catch(Exception ex){
			errors.inValidAmount = "Invalid Amount"
		}
		
		[errors:errors]
	}
	
	def rollPlannedTransactions(){
		println "geting rolling list"
		def rollingList = PlannedTransaction.withCriteria {
			eq("rolling","Y")
			lt("plannedTransactionDate",new Date().clearTime())
		}	
		if(rollingList){
			println "rolling list found"
			rollingList.each{plannedTransactionInstance ->
				println "rollint ${plannedTransactionInstance}"
				plannedTransactionInstance.plannedTransactionDate = plannedTransactionInstance.plannedTransactionDate + 1
			}
		}
		
	}
}
