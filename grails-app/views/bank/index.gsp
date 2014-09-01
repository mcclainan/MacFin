
<%@ page import="tracking.Bank" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bank.label', default: 'Bank')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-bank" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-bank" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="active" title="${message(code: 'bank.active.label', default: 'Active')}" />
					
						<g:sortableColumn property="hasHeading" title="${message(code: 'bank.hasHeading.label', default: 'Has Heading')}" />
					
						<g:sortableColumn property="bankName" title="${message(code: 'bank.bankName.label', default: 'Bank Name')}" />
					
						<g:sortableColumn property="creditColumn" title="${message(code: 'bank.creditColumn.label', default: 'Credit Column')}" />
					
						<g:sortableColumn property="debitColumn" title="${message(code: 'bank.debitColumn.label', default: 'Debit Column')}" />
					
						<g:sortableColumn property="amountColumn" title="${message(code: 'bank.amountColumn.label', default: 'Amount Column')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${bankInstanceList}" status="i" var="bankInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${bankInstance.id}">${fieldValue(bean: bankInstance, field: "active")}</g:link></td>
					
						<td>${fieldValue(bean: bankInstance, field: "hasHeading")}</td>
					
						<td>${fieldValue(bean: bankInstance, field: "bankName")}</td>
					
						<td>${fieldValue(bean: bankInstance, field: "creditColumn")}</td>
					
						<td>${fieldValue(bean: bankInstance, field: "debitColumn")}</td>
					
						<td>${fieldValue(bean: bankInstance, field: "amountColumn")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${bankInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
