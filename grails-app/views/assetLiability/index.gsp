
<%@ page import="assetLiability.AssetLiability" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="tracking">
		<g:set var="entityName" value="${message(code: 'assetLiability.label', default: 'AssetLiability')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-assetLiability" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-assetLiability" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'assetLiability.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'assetLiability.type.label', default: 'Type')}" />
					
						<th><g:message code="assetLiability.assetLiabilityClass.label" default="Asset Liability Class" /></th>
					
						<g:sortableColumn property="value" title="${message(code: 'assetLiability.value.label', default: 'Value')}" />
					
						<g:sortableColumn property="active" title="${message(code: 'assetLiability.active.label', default: 'Active')}" />
					
						<g:sortableColumn property="interestRate" title="${message(code: 'assetLiability.interestRate.label', default: 'Interest Rate')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${assetLiabilityInstanceList}" status="i" var="assetLiabilityInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${assetLiabilityInstance.id}">${fieldValue(bean: assetLiabilityInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: assetLiabilityInstance, field: "type")}</td>
					
						<td>${fieldValue(bean: assetLiabilityInstance, field: "assetLiabilityClass")}</td>
					
						<td>${fieldValue(bean: assetLiabilityInstance, field: "value")}</td>
					
						<td>${fieldValue(bean: assetLiabilityInstance, field: "active")}</td>
					
						<td>${fieldValue(bean: assetLiabilityInstance, field: "interestRate")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${assetLiabilityInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
