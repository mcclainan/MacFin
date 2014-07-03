<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tracking.Account"%>
<%@ page import="tracking.Transaction"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="planning"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'calendar.css')}" type="text/css">
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
<title>Cash Flow Calendar</title>
</head>
<body>
	<h2  class="dashBoardHeading">Cash Flow Calendar</h2>
	<g:form action="cashFlowCalendar">
		<g:select name="numberOfMonths" from="${1..12}" value="${numberOfMonths}"/>
		<g:submitButton name="Refresh"/>
	</g:form>
	<g:each in="${cashFlowCalendar.cashFlowMonthList}" var="cashFlowMonth">
		<g:render template="/budgetItem/calendar" model="${[cashFlowMonth:cashFlowMonth] }"/>
	</g:each>
</body>
</html>