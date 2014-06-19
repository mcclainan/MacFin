
<%@ page import="planning.BudgetItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="planning">
		<g:set var="entityName" value="${message(code: 'budgetItem.label', default: 'BudgetItem')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<style type="text/css">
			.budgetShow{
				font-size: 1.1em; 
				margin-left:1.40em;
				margin-right:1em;
				width:16em;
				float:left;
			}
			.cashFlowCalendarShow{
				font-size: 1.1em; 
				margin-right:1.40em;
				width:39em;
				float:left;
			}
			.mainContainer{
				width:100%;
				min-height: 17em;
			}
	table{
		border-collapse: separate;
	}
	tr > td:last-child, tr > th:last-child {
	    padding: 0em;
	}
	tr > td:first-child, tr > th:first-child {
	    padding: 0em;
	}
	td{
		padding:0;
		height: 5.5em;
	}
	th{
		width:14.28%;
	}
	td.calendarHead{
		height:2em;
		font-size:1.5em;
		vertical-align: middle;
		text-align: center;
	}
		</style>
	</head>
	<body>
		<div id="show-budgetItem" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<div class="mainContainer">
				<div class="budgetShow">
					<g:message code="year.label"/>: ${budgetItemInstance.year}<br/><br/>
					<g:message code="month.label"/>: ${utilities.Months.values()[budgetItemInstance.month].name}<br/><br/>
					<g:message code="category.label"/>: ${budgetItemInstance.category}<br/><br/>
					<g:message code="amount.label"/>: <g:formatNumber number="${budgetItemInstance.amount}" type="currency" currencyCode="USD" /> <br/><br/>
					<g:link action="view"><g:message code="budgetItem.change.message"/></g:link><br/><br/>
					<g:form url="[resource:budgetItemInstance, action:'delete']" method="DELETE">
						<fieldset class="buttons">
							<g:link class="edit" action="edit" resource="${budgetItemInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
							<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
						</fieldset>
					</g:form>
				</div>
				<div class="cashFlowCalendarShow">
					<g:render template="calendar" model="${[budgetItemInstance:budgetItemInstance,startDay:startDay]}"/>
				</div>
			</div>
			
			
		</div>
	</body>
</html>
