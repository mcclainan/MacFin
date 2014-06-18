<%@ page import="planning.BudgetItem" %>



<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'year', 'error')} required">
	<label for="year">
		<g:message code="budgetItem.year.label" default="Year" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="year" type="number" min="2011" max="2020" value="${budgetItemInstance.year}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'month', 'error')} required">
	<label for="month">
		<g:message code="budgetItem.month.label" default="Month" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="month" type="number" min="1" max="12" value="${budgetItemInstance.month}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'category', 'error')} required">
	<label for="category">
		<g:message code="budgetItem.category.label" default="Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="category" name="category.id" from="${category.Category.list()}" optionKey="id" required="" value="${budgetItemInstance?.category?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="budgetItem.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="text" name="amount" value="${fieldValue(bean: budgetItemInstance, field: 'amount')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'required', 'error')} ">
	<label for="required">
		<g:message code="budgetItem.required.label" default="Required" />
		
	</label>
	<g:select name="required" from="${budgetItemInstance.constraints.required.inList}" value="${budgetItemInstance?.required}" valueMessagePrefix="budgetItem.required" noSelection="['': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'required', 'error')} ">
	<label for="numberOfMonths">
		<g:message code="budgetItem.numberOfMonths.label" default="Number of Months" />
		
	</label>
	<g:select name="numberOfMonths" from="${1..12}"/>

</div>
