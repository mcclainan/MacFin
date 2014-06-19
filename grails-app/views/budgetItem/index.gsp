
<%@ page import="planning.BudgetItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="planning">
		<g:set var="entityName" value="${message(code: 'budgetItem.label', default: 'BudgetItem')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div id="list-budgetItem" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="year" title="${message(code: 'budgetItem.year.label', default: 'Year')}" />
					
						<g:sortableColumn property="month" title="${message(code: 'budgetItem.month.label', default: 'Month')}" />
					
						<th><g:message code="budgetItem.category.label" default="Category" /></th>
					
						<g:sortableColumn property="amount" title="${message(code: 'budgetItem.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="cash" title="${message(code: 'budgetItem.cash.label', default: 'Cash')}" />
					
						<g:sortableColumn property="required" title="${message(code: 'budgetItem.required.label', default: 'Required')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${budgetItemInstanceList}" status="i" var="budgetItemInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${budgetItemInstance.id}">${fieldValue(bean: budgetItemInstance, field: "year")}</g:link></td>
					
						<td>${fieldValue(bean: budgetItemInstance, field: "month")}</td>
					
						<td>${fieldValue(bean: budgetItemInstance, field: "category")}</td>
					
						<td>${fieldValue(bean: budgetItemInstance, field: "amount")}</td>
					
						<td>${fieldValue(bean: budgetItemInstance, field: "cash")}</td>
					
						<td>${fieldValue(bean: budgetItemInstance, field: "required")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${budgetItemInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
