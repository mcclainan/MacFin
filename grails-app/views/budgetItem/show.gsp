
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
				height:18em;
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
			.setOptions{
				width: 42em;
				height: 21em;
				float:left;
			}
			.calendarTable{
				margin:4em 0 0 7em
			}
			.calendarTableDay , .calendarTableWeek{
				height:4em;
			}
			.editBudgetItem,.changeBudgetItem{
				background-color: #efefef;
				border: medium none;
				box-shadow: 0 0 3px 1px #aaaaaa;
				margin: 0.1em 0 0;
				overflow: hidden;
				padding: 0.3em;
				visibility:hidden;
				height: 13.5em;
				width:21em;
				position:absolute;
				top:10em;
				left:1.4em;
				z-index: 1;
				padding:.5em;
			}
		</style>
		<g:javascript>
			function toggleElementVisibility(element,visibility){
				document.getElementById(element).style.visibility = visibility;
			}
		</g:javascript>
	</head>
	<body>
		
		<div id="show-budgetItem" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<div class="mainContainer" style="position:relative;">
				<div class="budgetShow">
					<g:message code="year.label"/>: ${budgetItemInstance?.year}<br/><br/>
					<g:message code="month.label"/>: ${utilities.Months.values()[budgetItemInstance?.month-1].name}<br/><br/>
					<g:message code="category.label"/>: ${budgetItemInstance?.category}<br/><br/>
					<g:message code="amount.label"/>: <g:formatNumber number="${budgetItemInstance?.amount}" type="currency" currencyCode="USD" /> <br/><br/>
					<a onclick="toggleElementVisibility('changeBudgetItem','visible')"><g:message code="budgetItem.change.message"/></a><br/><br/>
					<g:form action="delete">
						<fieldset class="buttons">
							<input type="button" class="edit" 
								value="${message(code:'default.button.edit.label',default:'Edit')}" 
								onclick="toggleElementVisibility('editBudgetItem','visible')"/>
							<g:submitButton name="delete" class="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
						</fieldset>
					</g:form>
				</div>
				<g:form controller="plannedTransaction" action="save">
					<div class="editBudgetItem" id="editBudgetItem">
						<g:render template="plannedTransactionSetControlls"/>
					</div>
					<div class="setOptions">
						<g:render template="plannedTransactionSetOptions"/>
					</div>
				</g:form>
				<div class="changeBudgetItem" id="changeBudgetItem">
					<g:render template="selectBudgetItem"/>
				</div>
			</div>
			<div class="cashFlowCalendarShow">
				<g:each in="${cashFlowCalendar.cashFlowMonthList}" var="cashFlowMonth">
					<g:render template="calendar" model="${[cashFlowMonth:cashFlowMonth]}"/>
				</g:each>
			</div>
			
			
		</div>
	</body>
</html>
