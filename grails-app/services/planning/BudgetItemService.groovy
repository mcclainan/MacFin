package planning

import grails.transaction.Transactional

@Transactional
class BudgetItemService {

    def create(BudgetItem budgetItemModel, Integer numberOfMonths) {
		List budgetItems = []
		for(int i = 0; i < numberOfMonths; i++){
			def budgetItem = new BudgetItem(year:budgetItemModel.year,
				                            month:budgetItemModel.month,
											category:budgetItemModel.category,
											amount:budgetItemModel.amount,
											required:budgetItemModel.required)
			try {
				if(!budgetItem.save()){
					throw new GroovyRuntimeException()
				}
			} catch (Exception e) {
				return budgetItem
			}
			budgetItems << budgetItem
			budgetItemModel.month ++
			if(budgetItemModel.month > 12){
				budgetItemModel.month = 1
				budgetItemModel.year++
			}
		}
		return budgetItems
    }
}
