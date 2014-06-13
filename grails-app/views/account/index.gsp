
<%@ page import="tracking.Account" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="tracking">
		<g:set var="entityName" value="${message(code: 'account.label', default: 'Account')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-account" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="list-account" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'account.name.label', default: 'Name')}" />

						<g:sortableColumn property="balance" title="${message(code: 'account.balance.label', default: 'Balance')}" />
						
						<g:sortableColumn property="cash" title="${message(code: 'account.cash.label', default: 'Cash')}" />
						
						<g:sortableColumn property="active" title="${message(code: 'account.active.label', default: 'Active')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${accountInstanceList}" status="i" var="accountInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${accountInstance.id}">${fieldValue(bean: accountInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: accountInstance, field: "balance")}</td>
						
						<td>${fieldValue(bean: accountInstance, field: "cash")}</td>
						
						<td>${fieldValue(bean: accountInstance, field: "active")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${accountInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
