<%@ page import="tracking.Bank" %>



<div class="fieldcontain ${hasErrors(bean: bankInstance, field: 'active', 'error')} ">
	<label for="active">
		<g:message code="bank.active.label" default="Active" />
		
	</label>
	<g:select name="active" from="${bankInstance.constraints.active.inList}" value="${bankInstance?.active}" valueMessagePrefix="bank.active" noSelection="['': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: bankInstance, field: 'hasHeading', 'error')} ">
	<label for="hasHeading">
		<g:message code="bank.hasHeading.label" default="Has Heading" />
		
	</label>
	<g:select name="hasHeading" from="${bankInstance.constraints.hasHeading.inList}" value="${bankInstance?.hasHeading}" valueMessagePrefix="bank.hasHeading" noSelection="['': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: bankInstance, field: 'bankName', 'error')} ">
	<label for="bankName">
		<g:message code="bank.bankName.label" default="Bank Name" />
		
	</label>
	<g:textField name="bankName" value="${bankInstance?.bankName}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: bankInstance, field: 'creditColumn', 'error')} ">
	<label for="creditColumn">
		<g:message code="bank.creditColumn.label" default="Credit Column" />
		
	</label>
	<g:field name="creditColumn" type="number" value="${bankInstance.creditColumn}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: bankInstance, field: 'debitColumn', 'error')} ">
	<label for="debitColumn">
		<g:message code="bank.debitColumn.label" default="Debit Column" />
		
	</label>
	<g:field name="debitColumn" type="number" value="${bankInstance.debitColumn}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: bankInstance, field: 'accounts', 'error')} ">
	<label for="accounts">
		<g:message code="bank.accounts.label" default="Accounts" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${bankInstance?.accounts?}" var="a">
    <li><g:link controller="account" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="account" action="create" params="['bank.id': bankInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'account.label', default: 'Account')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: bankInstance, field: 'amountColumn', 'error')} required">
	<label for="amountColumn">
		<g:message code="bank.amountColumn.label" default="Amount Column" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="amountColumn" type="number" value="${bankInstance.amountColumn}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: bankInstance, field: 'dateColumn', 'error')} required">
	<label for="dateColumn">
		<g:message code="bank.dateColumn.label" default="Date Column" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="dateColumn" type="number" value="${bankInstance.dateColumn}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: bankInstance, field: 'dateFormat', 'error')} ">
	<label for="dateFormat">
		<g:message code="bank.dateFormat.label" default="Date Format" />
		
	</label>
	<g:textField name="dateFormat" value="${bankInstance?.dateFormat}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: bankInstance, field: 'descriptionColumn', 'error')} required">
	<label for="descriptionColumn">
		<g:message code="bank.descriptionColumn.label" default="Description Column" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="descriptionColumn" type="number" value="${bankInstance.descriptionColumn}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: bankInstance, field: 'hasMultipleAmountColumns', 'error')} ">
	<label for="hasMultipleAmountColumns">
		<g:message code="bank.hasMultipleAmountColumns.label" default="Has Multiple Amount Columns" />
		
	</label>
	<g:textField name="hasMultipleAmountColumns" value="${bankInstance?.hasMultipleAmountColumns}"/>

</div>

