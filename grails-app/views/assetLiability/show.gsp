
<%@ page import="assetLiability.AssetLiability" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="tracking">
		<g:set var="entityName" value="${message(code: 'assetLiability.label', default: 'AssetLiability')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-assetLiability" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-assetLiability" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list assetLiability">
			
				<g:if test="${assetLiabilityInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="assetLiability.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${assetLiabilityInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="assetLiability.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${assetLiabilityInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.assetLiabilityClass}">
				<li class="fieldcontain">
					<span id="assetLiabilityClass-label" class="property-label"><g:message code="assetLiability.assetLiabilityClass.label" default="Asset Liability Class" /></span>
					
						<span class="property-value" aria-labelledby="assetLiabilityClass-label"><g:link controller="assetLiabilityClass" action="show" id="${assetLiabilityInstance?.assetLiabilityClass?.id}">${assetLiabilityInstance?.assetLiabilityClass?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.value}">
				<li class="fieldcontain">
					<span id="value-label" class="property-label"><g:message code="assetLiability.value.label" default="Value" /></span>
					
						<span class="property-value" aria-labelledby="value-label"><g:fieldValue bean="${assetLiabilityInstance}" field="value"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.active}">
				<li class="fieldcontain">
					<span id="active-label" class="property-label"><g:message code="assetLiability.active.label" default="Active" /></span>
					
						<span class="property-value" aria-labelledby="active-label"><g:fieldValue bean="${assetLiabilityInstance}" field="active"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.interestRate}">
				<li class="fieldcontain">
					<span id="interestRate-label" class="property-label"><g:message code="assetLiability.interestRate.label" default="Interest Rate" /></span>
					
						<span class="property-value" aria-labelledby="interestRate-label"><g:fieldValue bean="${assetLiabilityInstance}" field="interestRate"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.creditLimit}">
				<li class="fieldcontain">
					<span id="creditLimit-label" class="property-label"><g:message code="assetLiability.creditLimit.label" default="Credit Limit" /></span>
					
						<span class="property-value" aria-labelledby="creditLimit-label"><g:fieldValue bean="${assetLiabilityInstance}" field="creditLimit"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.categories}">
				<li class="fieldcontain">
					<span id="categories-label" class="property-label"><g:message code="assetLiability.categories.label" default="Categories" /></span>
					
						<g:each in="${assetLiabilityInstance.categories}" var="c">
						<span class="property-value" aria-labelledby="categories-label"><g:link controller="category" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${assetLiabilityInstance?.transactions}">
				<li class="fieldcontain">
					<span id="transactions-label" class="property-label"><g:message code="assetLiability.transactions.label" default="Transactions" /></span>
					
						<g:each in="${assetLiabilityInstance.transactions}" var="t">
						<span class="property-value" aria-labelledby="transactions-label"><g:link controller="transaction" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:assetLiabilityInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${assetLiabilityInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
