
<%@ page import="planning.BudgetItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="planning">
		<g:set var="entityName" value="${message(code: 'budgetItem.label', default: 'BudgetItem')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'calendar.css')}" type="text/css">
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
			.calendarTable{
				margin: 0;
    			width: 39em
			}
			.calendarTableHeaderDate{
				background: none repeat scroll 0 0 #006699
			}
			.calendarTableTitle{
				background: none repeat scroll 0 0 #059fff;
			}
			.calendarTableWeek{
				height: 4em
			}
			.chageBudgetItem{
				background-color: #efefef;
			    border: medium none;
			    box-shadow: 0 0 3px 1px #aaaaaa;
			    margin: 0.1em 0 0;
			    overflow: hidden;
			    padding: 0.3em;
			    height: 13em;
			    left: 1.4em;
			    position: absolute;
			    top: 11em;
			    width: 17.9em;
			    z-index: 1;
			}
		</style>
	</head>
	<body>
		
		<div id="show-budgetItem" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<div class="mainContainer" style="position:relative;">
				<div class="chageBudgetItem"></div>
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
					<g:each in="${cashFlowCalendar.cashFlowMonthList}" var="cashFlowMonth">
						<g:render template="calendar" model="${[cashFlowMonth:cashFlowMonth]}"/>
					</g:each>
				</div>
			</div>
			
			
		</div>
	</body>
</html>
