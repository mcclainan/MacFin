<%@ page import="planning.PlannedTransaction" %>



<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'plannedTransactionDate', 'error')} required">
	<label for="plannedTransactionDate">
		<g:message code="plannedTransaction.plannedTransactionDate.label" default="Planned Transaction Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="plannedTransactionDate" precision="day"  value="${plannedTransactionInstance?.plannedTransactionDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="plannedTransaction.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="amount" value="${fieldValue(bean: plannedTransactionInstance, field: 'amount')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'cash', 'error')} ">
	<label for="cash">
		<g:message code="plannedTransaction.cash.label" default="Cash" />
		
	</label>
	<g:select name="cash" from="${plannedTransactionInstance.constraints.cash.inList}" value="${plannedTransactionInstance?.cash}" valueMessagePrefix="plannedTransaction.cash" noSelection="['': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'exempt', 'error')} ">
	<label for="exempt">
		<g:message code="plannedTransaction.exempt.label" default="Exempt" />
		
	</label>
	<g:select name="exempt" from="${plannedTransactionInstance.constraints.exempt.inList}" value="${plannedTransactionInstance?.exempt}" valueMessagePrefix="plannedTransaction.exempt" noSelection="['': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'rolling', 'error')} ">
	<label for="rolling">
		<g:message code="plannedTransaction.rolling.label" default="Rolling" />
		
	</label>
	<g:select name="rolling" from="${plannedTransactionInstance.constraints.rolling.inList}" value="${plannedTransactionInstance?.rolling}" valueMessagePrefix="plannedTransaction.rolling" noSelection="['': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'category', 'error')} required">
	<label for="category">
		<g:message code="plannedTransaction.category.label" default="Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="category" name="category.id" from="${category.Category.list()}" optionKey="id" required="" value="${plannedTransactionInstance?.category?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'budgetItem', 'error')} required">
	<label for="budgetItem">
		<g:message code="plannedTransaction.budgetItem.label" default="Budget Item" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="budgetItem" name="budgetItem.id" from="${planning.BudgetItem.list()}" optionKey="id" required="" value="${plannedTransactionInstance?.budgetItem?.id}" class="many-to-one"/>

</div>

