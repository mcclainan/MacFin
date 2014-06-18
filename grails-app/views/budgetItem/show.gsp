
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
	/* Calendar Styling */
	.calendar{
		width:40em;
		height: 42em;
	}
	.calendarBody{
		width:40em;
		height:40em;
	}
	.calendarHead{
		width:40em;
		height:1.3em;
	}
	
	.calendarRow{
		width:40em;
		height:6.5em;
	}
	.calendarCell{
		height: 6.5em;
    	width: 5.57em;
		border: .1em;
		border-style: solid;
		float:left;
	}
	.calendarCellHeader{
		height: 1.3em;
    	width: 1.57em;
		background-color:#66A0BE;
	}
	.calendarHeadCell{
		width:5.5em;
		height:1.3em;
		background-color:#006192;
		color:#FFFFFF;
		float:left;
		padding:.1em;
	}
	table{
		border-collapse: separate;
	}
	tr > td:last-child, tr > th:last-child {
	    padding-right: 0em;
	    padding-top: 0em;
	}
	tr > td:first-child, tr > th:first-child {
	    padding-left: 0em;
	    padding-top: 0em;
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
					<g:render template="calendar"/>
				</div>
			</div>
			
			
		</div>
	</body>
</html>
