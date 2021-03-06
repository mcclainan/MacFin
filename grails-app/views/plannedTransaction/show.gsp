
<%@ page import="planning.PlannedTransaction" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'plannedTransaction.label', default: 'PlannedTransaction')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-plannedTransaction" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-plannedTransaction" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list plannedTransaction">
			
				<g:if test="${plannedTransactionInstance?.plannedTransactionDate}">
				<li class="fieldcontain">
					<span id="plannedTransactionDate-label" class="property-label"><g:message code="plannedTransaction.plannedTransactionDate.label" default="Planned Transaction Date" /></span>
					
						<span class="property-value" aria-labelledby="plannedTransactionDate-label"><g:formatDate date="${plannedTransactionInstance?.plannedTransactionDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedTransactionInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="plannedTransaction.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${plannedTransactionInstance}" field="amount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedTransactionInstance?.cash}">
				<li class="fieldcontain">
					<span id="cash-label" class="property-label"><g:message code="plannedTransaction.cash.label" default="Cash" /></span>
					
						<span class="property-value" aria-labelledby="cash-label"><g:fieldValue bean="${plannedTransactionInstance}" field="cash"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedTransactionInstance?.exempt}">
				<li class="fieldcontain">
					<span id="exempt-label" class="property-label"><g:message code="plannedTransaction.exempt.label" default="Exempt" /></span>
					
						<span class="property-value" aria-labelledby="exempt-label"><g:fieldValue bean="${plannedTransactionInstance}" field="exempt"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedTransactionInstance?.rolling}">
				<li class="fieldcontain">
					<span id="rolling-label" class="property-label"><g:message code="plannedTransaction.rolling.label" default="Rolling" /></span>
					
						<span class="property-value" aria-labelledby="rolling-label"><g:fieldValue bean="${plannedTransactionInstance}" field="rolling"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedTransactionInstance?.category}">
				<li class="fieldcontain">
					<span id="category-label" class="property-label"><g:message code="plannedTransaction.category.label" default="Category" /></span>
					
						<span class="property-value" aria-labelledby="category-label"><g:link controller="category" action="show" id="${plannedTransactionInstance?.category?.id}">${plannedTransactionInstance?.category?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${plannedTransactionInstance?.budgetItem}">
				<li class="fieldcontain">
					<span id="budgetItem-label" class="property-label"><g:message code="plannedTransaction.budgetItem.label" default="Budget Item" /></span>
					
						<span class="property-value" aria-labelledby="budgetItem-label"><g:link controller="budgetItem" action="show" id="${plannedTransactionInstance?.budgetItem?.id}">${plannedTransactionInstance?.budgetItem?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:plannedTransactionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${plannedTransactionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
