
<%@ page import="planning.BudgetItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'budgetItem.label', default: 'BudgetItem')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-budgetItem" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-budgetItem" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list budgetItem">
			
				<g:if test="${budgetItemInstance?.year}">
				<li class="fieldcontain">
					<span id="year-label" class="property-label"><g:message code="budgetItem.year.label" default="Year" /></span>
					
						<span class="property-value" aria-labelledby="year-label"><g:fieldValue bean="${budgetItemInstance}" field="year"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.month}">
				<li class="fieldcontain">
					<span id="month-label" class="property-label"><g:message code="budgetItem.month.label" default="Month" /></span>
					
						<span class="property-value" aria-labelledby="month-label"><g:fieldValue bean="${budgetItemInstance}" field="month"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.category}">
				<li class="fieldcontain">
					<span id="category-label" class="property-label"><g:message code="budgetItem.category.label" default="Category" /></span>
					
						<span class="property-value" aria-labelledby="category-label"><g:link controller="category" action="show" id="${budgetItemInstance?.category?.id}">${budgetItemInstance?.category?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="budgetItem.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${budgetItemInstance}" field="amount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.cash}">
				<li class="fieldcontain">
					<span id="cash-label" class="property-label"><g:message code="budgetItem.cash.label" default="Cash" /></span>
					
						<span class="property-value" aria-labelledby="cash-label"><g:fieldValue bean="${budgetItemInstance}" field="cash"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.required}">
				<li class="fieldcontain">
					<span id="required-label" class="property-label"><g:message code="budgetItem.required.label" default="Required" /></span>
					
						<span class="property-value" aria-labelledby="required-label"><g:fieldValue bean="${budgetItemInstance}" field="required"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.plannedTransactions}">
				<li class="fieldcontain">
					<span id="plannedTransactions-label" class="property-label"><g:message code="budgetItem.plannedTransactions.label" default="Planned Transactions" /></span>
					
						<g:each in="${budgetItemInstance.plannedTransactions}" var="p">
						<span class="property-value" aria-labelledby="plannedTransactions-label"><g:link controller="plannedTransaction" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${budgetItemInstance?.transactions}">
				<li class="fieldcontain">
					<span id="transactions-label" class="property-label"><g:message code="budgetItem.transactions.label" default="Transactions" /></span>
					
						<g:each in="${budgetItemInstance.transactions}" var="t">
						<span class="property-value" aria-labelledby="transactions-label"><g:link controller="transaction" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:budgetItemInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${budgetItemInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
