<%@ page import="tracking.Transaction" %>
<g:hiddenField name="id" value="${transactionInstance.id}"/>
<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'transactionDate', 'error')} required">
	<label for="transactionDate">
		<g:message code="transaction.transactionDate.label" default="Transaction Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="transactionDate" precision="day"  value="${transactionInstance?.transactionDate}" />

</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'category', 'error')} required">
	<label for="category">
		<g:message code="transaction.category.label" default="Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="category" name="category.id" from="${category.Category.findAllByActive("Y",[sort:"name"])}" optionKey="id" required="" value="${transactionInstance?.category?.id}" class="category"/>

</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="transaction.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${transactionInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="transaction.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="text" name="amount" value="${fieldValue(bean: transactionInstance, field: 'amount')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'notes', 'error')} ">
	<label for="notes">
		<g:message code="transaction.notes.label" default="Notes" />
		
	</label>
	<g:textArea name="notes" cols="40" rows="5" maxlength="255" value="${transactionInstance?.notes}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: transactionInstance, field: 'account', 'error')} required">
	<label for="account">
		<g:message code="transaction.account.label" default="Account" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="account" name="account.id" from="${tracking.Account.findAllByActive("Y")}" optionKey="id" required="" value="${transactionInstance?.account?.id}" class="many-to-one"/>

</div>



