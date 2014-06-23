<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tracking.Account"%>
<%@ page import="tracking.Transaction"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="home"/>
<style type="text/css">
	.message{
		width:76.25em;
	}
	#dialogBox {
	    background: none repeat scroll 0 0 #EFEFEF;
	    border-color: #006192;
	    border-style: outset;
	    border-width: 0.5em;
	    height: 20em;
	    margin: 6em 1em 1em 24em;
	    position: fixed;
	    visibility: hidden;
	    width: 40em;
	    padding:1em;
	    z-index: 1;
	}
	#dialogBoxHead{
		height: 11%;
	}
	#dialogBoxBody{
	    overflow:scroll;
		height: 77%;
	}
	#dialogBoxFooter{
		height: 11%;
		text-align: center;
	}
	
	.calendarTable{
		width:45em;
		margin: 2em 0 0 10em;
		border-collapse: separate;
		border-top-color: black
	}
	.calendarTableHeaderDate{
		border-style : double;
	}
	.calendarHead{
		font-size: 1.3em;
		text-align: center;
	}
	.calendarTableDayHeaders{
	}
	.calendarTableDayHeader{
				padding: 0.2em 1em;
		    text-align: center;
		    width: 5em;
		}
	.calendarTableWeek{
		height:8em;
		border-style: double;
	}
	.calendarTableDay{
		border-style: solid;
	    border-width: 0.1em;
	    padding: 0;
	    text-align: left;
	}
	tr > td:last-child,tr > td:first-child  {
	    padding: 0em;
	}
	tr > th:last-child,tr> th:first-child {
	    padding: 0.2em 1em;
	    text-align: center;
	    width: 5em;
	}
	.dashBoardHeading{
		font-size: 2em;
	}
</style>
<g:javascript library="prototype" />
<script type="text/javascript">
	var refresh = "false"
	function toggleDialogBoxVisibility(on){
		if(on=="on"){
			document.getElementById("dialogBox").style.visibility = "visible"
		}else{
			document.getElementById("dialogBox").style.visibility = "hidden"
		}	
	}	

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
				<table style="width:40em">
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