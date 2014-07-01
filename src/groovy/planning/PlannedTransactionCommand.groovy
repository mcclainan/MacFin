package planning

import org.springframework.context.MessageSourceResolvable;


@grails.validation.Validateable
class PlannedTransactionCommand {
	Date startDate
	Date endDate
	Double amount
	Long budgetItemId
	BudgetItem budgetItem
	String replaceCurrentSet
	String amountOption
	String createMode
	String frequencyOption
	String exempt = 'N'
	
	static constraints = {
		startDate validator:{val->
			if(val<new Date().clearTime()){
				return['pastDate']
			}else if((val.getAt(Calendar.MONTH)+1)!=budgetItem.month ||
			         (val.getAt(calendar.YEAR)+1)!=budgetItem.year){
				return['budgetItemMisMatch']	 
			}
		}
		endDate nullable:true, validator{val,obj->
			if(val){
				if(val.clearTime()<=obj.startDate.clearTime()){
					return['endBeforeStart']
				}
			}
		}
		budgetItemId validator:{val,obj->
			obj.budgetItem = BudgetItem.get(val)
			if(!obj.budgetItem){
				return['budgetItem.not.found']
			}
		}
		budgetItem nullable:false
		amount nullable:true, validator{val,obj->
			if((obj.amountOption=='addAmount'|| obj.createMode == "single")&& !val){
				return['required']
			}
		}
		frequencyOption nullable:true, validator{val,obj->
			if(obj.createMode == "single" && !val){
				return['required']
			}
		}
		exempt size:1..1
	}
}

