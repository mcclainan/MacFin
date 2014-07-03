<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tracking.Account"%>
<%@ page import="tracking.Transaction"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="home"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'calendar.css')}" type="text/css">
<style type="text/css">
	.message{
		width:76.25em;
	}
	
</style>
<g:javascript library="prototype" />
<script type="text/javascript">
	var refresh = "false"
		

	function setRefresh(value){
		refresh = value
	}

	function refreshPage(){
		if(refresh == "true"){
			location.reload() 
		}
	}
	
</script>
<title>Home</title>
</head>
<body>
	
	<h2 class="dashBoardHeading">Recent Transactions</h2>
	<table style="margin: 0 3em; width: 59em;">
		<tr>
			<th>Date</th>
			<th>Category</th>
			<th>Description</th>
			<th>Amount</th>
			<th>Account</th>
		</tr>
		<g:each
			in="${Transaction.list(max: 5, sort: "transactionDate", order: "desc")}"
			status="i" var="transactionInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
	
				<td><g:formatDate
						date="${transactionInstance.transactionDate}"
						format="MM/dd/yyyy" /></td>
	
				<td>
					${fieldValue(bean: transactionInstance, field: "name")}
				</td>
	
				<td>
					${fieldValue(bean: transactionInstance, field: "category")}
				</td>
	
				<td>
					${fieldValue(bean: transactionInstance, field: "amount")}
				</td>
	
				<td>
					${fieldValue(bean: transactionInstance, field: "account")}
				</td>
	
			</tr>
		</g:each>
	</table>
	<h2  class="dashBoardHeading">Cash Flow Calendar</h2> <g:link controller="plannedTransaction" action="cashFlowCalendar">(view full calendar)</g:link>
	<g:each in="${cashFlowCalendar.cashFlowMonthList}" var="cashFlowMonth">
		<g:render template="/budgetItem/calendar" model="${[cashFlowMonth:cashFlowMonth] }"/>
	</g:each>
</body>
</html>