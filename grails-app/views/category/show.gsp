
<%@ page import="category.Category" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="recMaint">
		<g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-category" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-category" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list category">
			
				<g:if test="${categoryInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="category.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${categoryInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.priority}">
				<li class="fieldcontain">
					<span id="priority-label" class="property-label"><g:message code="category.priority.label" default="Priority" /></span>
					
						<span class="property-value" aria-labelledby="priority-label"><g:fieldValue bean="${categoryInstance}" field="priority"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.cash}">
				<li class="fieldcontain">
					<span id="cash-label" class="property-label"><g:message code="category.cash.label" default="Cash" /></span>
					
						<span class="property-value" aria-labelledby="cash-label"><g:fieldValue bean="${categoryInstance}" field="cash"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="category.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${categoryInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.active}">
				<li class="fieldcontain">
					<span id="active-label" class="property-label"><g:message code="category.active.label" default="Active" /></span>
					
						<span class="property-value" aria-labelledby="active-label"><g:fieldValue bean="${categoryInstance}" field="active"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.displayOnMobile}">
				<li class="fieldcontain">
					<span id="displayOnMobile-label" class="property-label"><g:message code="category.displayOnMobile.label" default="Display On Mobile" /></span>
					
						<span class="property-value" aria-labelledby="displayOnMobile-label"><g:fieldValue bean="${categoryInstance}" field="displayOnMobile"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.assetLiability}">
				<li class="fieldcontain">
					<span id="assetLiability-label" class="property-label"><g:message code="category.assetLiability.label" default="Asset Liability" /></span>
					
						<span class="property-value" aria-labelledby="assetLiability-label"><g:link controller="assetLiability" action="show" id="${categoryInstance?.assetLiability?.id}">${categoryInstance?.assetLiability?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.assetLiabilityAction}">
				<li class="fieldcontain">
					<span id="assetLiabilityAction-label" class="property-label"><g:message code="category.assetLiabilityAction.label" default="Asset Liability Action" /></span>
					
						<span class="property-value" aria-labelledby="assetLiabilityAction-label"><g:fieldValue bean="${categoryInstance}" field="assetLiabilityAction"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.budgetItems}">
				<li class="fieldcontain">
					<span id="budgetItems-label" class="property-label"><g:message code="category.budgetItems.label" default="Budget Items" /></span>
					
						<g:each in="${categoryInstance.budgetItems}" var="b">
						<span class="property-value" aria-labelledby="budgetItems-label"><g:link controller="budgetItem" action="show" id="${b.id}">${b?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.metaCategory}">
				<li class="fieldcontain">
					<span id="metaCategory-label" class="property-label"><g:message code="category.metaCategory.label" default="Meta Category" /></span>
					
						<span class="property-value" aria-labelledby="metaCategory-label"><g:link controller="metaCategory" action="show" id="${categoryInstance?.metaCategory?.id}">${categoryInstance?.metaCategory?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.plannedTransactions}">
				<li class="fieldcontain">
					<span id="plannedTransactions-label" class="property-label"><g:message code="category.plannedTransactions.label" default="Planned Transactions" /></span>
					
						<g:each in="${categoryInstance.plannedTransactions}" var="p">
						<span class="property-value" aria-labelledby="plannedTransactions-label"><g:link controller="plannedTransaction" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${categoryInstance?.transactions}">
				<li class="fieldcontain">
					<span id="transactions-label" class="property-label"><g:message code="category.transactions.label" default="Transactions" /></span>
					
						<g:each in="${categoryInstance.transactions}" var="t">
						<span class="property-value" aria-labelledby="transactions-label"><g:link controller="transaction" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:categoryInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${categoryInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
