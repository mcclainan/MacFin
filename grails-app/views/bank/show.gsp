
<%@ page import="tracking.Bank" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bank.label', default: 'Bank')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-bank" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-bank" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list bank">
			
				<g:if test="${bankInstance?.active}">
				<li class="fieldcontain">
					<span id="active-label" class="property-label"><g:message code="bank.active.label" default="Active" /></span>
					
						<span class="property-value" aria-labelledby="active-label"><g:fieldValue bean="${bankInstance}" field="active"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankInstance?.hasHeading}">
				<li class="fieldcontain">
					<span id="hasHeading-label" class="property-label"><g:message code="bank.hasHeading.label" default="Has Heading" /></span>
					
						<span class="property-value" aria-labelledby="hasHeading-label"><g:fieldValue bean="${bankInstance}" field="hasHeading"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankInstance?.bankName}">
				<li class="fieldcontain">
					<span id="bankName-label" class="property-label"><g:message code="bank.bankName.label" default="Bank Name" /></span>
					
						<span class="property-value" aria-labelledby="bankName-label"><g:fieldValue bean="${bankInstance}" field="bankName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankInstance?.creditColumn}">
				<li class="fieldcontain">
					<span id="creditColumn-label" class="property-label"><g:message code="bank.creditColumn.label" default="Credit Column" /></span>
					
						<span class="property-value" aria-labelledby="creditColumn-label"><g:fieldValue bean="${bankInstance}" field="creditColumn"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankInstance?.debitColumn}">
				<li class="fieldcontain">
					<span id="debitColumn-label" class="property-label"><g:message code="bank.debitColumn.label" default="Debit Column" /></span>
					
						<span class="property-value" aria-labelledby="debitColumn-label"><g:fieldValue bean="${bankInstance}" field="debitColumn"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankInstance?.accounts}">
				<li class="fieldcontain">
					<span id="accounts-label" class="property-label"><g:message code="bank.accounts.label" default="Accounts" /></span>
					
						<g:each in="${bankInstance.accounts}" var="a">
						<span class="property-value" aria-labelledby="accounts-label"><g:link controller="account" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${bankInstance?.amountColumn}">
				<li class="fieldcontain">
					<span id="amountColumn-label" class="property-label"><g:message code="bank.amountColumn.label" default="Amount Column" /></span>
					
						<span class="property-value" aria-labelledby="amountColumn-label"><g:fieldValue bean="${bankInstance}" field="amountColumn"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankInstance?.dateColumn}">
				<li class="fieldcontain">
					<span id="dateColumn-label" class="property-label"><g:message code="bank.dateColumn.label" default="Date Column" /></span>
					
						<span class="property-value" aria-labelledby="dateColumn-label"><g:fieldValue bean="${bankInstance}" field="dateColumn"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankInstance?.dateFormat}">
				<li class="fieldcontain">
					<span id="dateFormat-label" class="property-label"><g:message code="bank.dateFormat.label" default="Date Format" /></span>
					
						<span class="property-value" aria-labelledby="dateFormat-label"><g:fieldValue bean="${bankInstance}" field="dateFormat"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankInstance?.descriptionColumn}">
				<li class="fieldcontain">
					<span id="descriptionColumn-label" class="property-label"><g:message code="bank.descriptionColumn.label" default="Description Column" /></span>
					
						<span class="property-value" aria-labelledby="descriptionColumn-label"><g:fieldValue bean="${bankInstance}" field="descriptionColumn"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${bankInstance?.hasMultipleAmountColumns}">
				<li class="fieldcontain">
					<span id="hasMultipleAmountColumns-label" class="property-label"><g:message code="bank.hasMultipleAmountColumns.label" default="Has Multiple Amount Columns" /></span>
					
						<span class="property-value" aria-labelledby="hasMultipleAmountColumns-label"><g:fieldValue bean="${bankInstance}" field="hasMultipleAmountColumns"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:bankInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${bankInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
