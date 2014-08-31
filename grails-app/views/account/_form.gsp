<%@ page import="tracking.Account" %>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="account.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${accountInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'balance', 'error')} required">
	<label for="balance">
		<g:message code="account.balance.label" default="Balance" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="text" name="balance"  value="${fieldValue(bean: accountInstance, field: 'balance')}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'interestRate', 'error')} ">
	<label for="interestRate">
		<g:message code="account.interestRate.label" default="Interest Rate" />
		
	</label>
	<g:field type="text" name="interestRate" value="${fieldValue(bean: accountInstance, field: 'interestRate')?:0}"/>

</div>
<g:if test="${params.action != "create" }">
	<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'active', 'error')} ">
		<label for="active">
			<g:message code="account.active.label" default="Active" />
		</label>
		<g:select name="active" from="${accountInstance.constraints.active.inList}" value="${accountInstance?.active}" valueMessagePrefix="account.active" noSelection="['': '']"/>
	</div>
</g:if>

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'cash', 'error')} ">
	<label for="cash">
		<g:message code="account.cash.label" default="Cash" />
		
	</label>
	<g:select name="cash" from="${accountInstance.constraints.cash.inList}" value="${accountInstance?.cash}" valueMessagePrefix="account.cash" noSelection="['': '']"/>

</div>
<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'type', 'error')} ">
	<label for="cash">
		<g:message code="account.type.label" default="Type" />
		
	</label>
	<g:select name="type" from="${accountInstance.constraints.type.inList}" value="${accountInstance?.type}" valueMessagePrefix="account.type" noSelection="['': '']"/>

</div>
<g:if test="${params.action != "create" }">

<div class="fieldcontain ${hasErrors(bean: accountInstance, field: 'transactions', 'error')} ">
	<label for="transactions">
		<g:message code="account.transactions.label" default="Transactions" />
		
	</label>
<ul class="one-to-many">
<g:each in="${accountInstance?.transactions?}" var="t">
    <li><g:link controller="transaction" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="transaction" action="create" params="['account.id': accountInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'transaction.label', default: 'Transaction')])}</g:link>
</li>
</ul>


</div>

</g:if>