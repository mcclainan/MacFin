
<%@ page import="tracking.BankRecord" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="tracking">
		<g:set var="entityName" value="${message(code: 'bankRecord.label', default: 'BankRecord')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-bankRecord" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="list-bankRecord" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="bankRecord.account.label" default="Account" /></th>
					
						<g:sortableColumn property="transactionDate" title="${message(code: 'bankRecord.transactionDate.label', default: 'Transaction Date')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'bankRecord.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="amount" title="${message(code: 'bankRecord.amount.label', default: 'Amount')}" />
					
						<th><g:message code="bankRecord.transaction.label" default="Transaction" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${bankRecordInstanceList}" status="i" var="bankRecordInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${bankRecordInstance.id}">${fieldValue(bean: bankRecordInstance, field: "account")}</g:link></td>
					
						<td><g:formatDate date="${bankRecordInstance.transactionDate}" /></td>
					
						<td>${fieldValue(bean: bankRecordInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: bankRecordInstance, field: "amount")}</td>
					
						<td>${fieldValue(bean: bankRecordInstance, field: "transaction")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${bankRecordInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
