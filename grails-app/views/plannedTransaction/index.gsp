
<%@ page import="planning.PlannedTransaction" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'plannedTransaction.label', default: 'PlannedTransaction')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-plannedTransaction" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-plannedTransaction" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="plannedTransactionDate" title="${message(code: 'plannedTransaction.plannedTransactionDate.label', default: 'Planned Transaction Date')}" />
					
						<g:sortableColumn property="amount" title="${message(code: 'plannedTransaction.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="cash" title="${message(code: 'plannedTransaction.cash.label', default: 'Cash')}" />
					
						<g:sortableColumn property="exempt" title="${message(code: 'plannedTransaction.exempt.label', default: 'Exempt')}" />
					
						<g:sortableColumn property="rolling" title="${message(code: 'plannedTransaction.rolling.label', default: 'Rolling')}" />
					
						<th><g:message code="plannedTransaction.category.label" default="Category" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${plannedTransactionInstanceList}" status="i" var="plannedTransactionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${plannedTransactionInstance.id}">${fieldValue(bean: plannedTransactionInstance, field: "plannedTransactionDate")}</g:link></td>
					
						<td>${fieldValue(bean: plannedTransactionInstance, field: "amount")}</td>
					
						<td>${fieldValue(bean: plannedTransactionInstance, field: "cash")}</td>
					
						<td>${fieldValue(bean: plannedTransactionInstance, field: "exempt")}</td>
					
						<td>${fieldValue(bean: plannedTransactionInstance, field: "rolling")}</td>
					
						<td>${fieldValue(bean: plannedTransactionInstance, field: "category")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${plannedTransactionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
