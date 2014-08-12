
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
				margin-right:14.4em;
				width:39em;
				float:right;
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
					<span style="font-weight: bold;"><g:message code="year.label"/>:</span> ${budgetItemInstance?.year}<br/><br/>
					<span style="font-weight: bold;"><g:message code="month.label"/>:</span> ${utilities.Months.values()[budgetItemInstance?.month-1].name}<br/><br/>
					<span style="font-weight: bold;"><g:message code="category.label"/>:</span> ${budgetItemInstance?.category}<br/><br/>
					<span style="font-weight: bold;"><g:message code="amount.label"/>:</span> <g:formatNumber number="${budgetItemInstance?.amount}" type="currency" currencyCode="USD" /> <br/><br/>
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
						<g:render template="/budgetItem/plannedTransactionSetControlls"/>
					</div>
					<div class="setOptions">
						<g:render template="/budgetItem/plannedTransactionSetOptions"/>
					</div>
				</g:form>
				<div class="changeBudgetItem" id="changeBudgetItem">
					<g:render template="/budgetItem/selectBudgetItem"/>
				</div>
			</div>
			<div style="float:left; margin: 5em 0 0 -7em;">
					<h2>Planned Transaction List</h2>
					<ul>
						<g:each in="${budgetItemInstance.plannedTransactions}" var="pt">
							<li>
								<g:link controller="plannedTransaction" action="show" id="${pt.id}" target="_blank">
									Day: <g:formatDate date="${pt.plannedTransactionDate}" format="dd"/> Amount:<g:formatNumber number="${pt.amount}" type="currency" currencyCode="USD" />
								</g:link>
							</li>
						</g:each>
					</ul>
				</div>
			<div class="cashFlowCalendarShow">
				<g:each in="${cashFlowCalendar.cashFlowMonthList}" var="cashFlowMonth">
					<g:render template="/budgetItem/calendar" model="${[cashFlowMonth:cashFlowMonth]}"/>
				</g:each>
			</div>
			
			
		</div>
	</body>
</html>
