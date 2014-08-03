<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="reports">
<title>Reports Main</title>
<style>
	h1{
		font-size:2em;
	}
	.menuItem{
		font-size: 1.5em;
	}
</style>
</head>
<body>
	<h1>Full Year Summary for ${year}</h1>
	<br/>
		<g:form>
			<g:select name="year" from="${2012..2020}" value="${year}"/> <g:submitButton name="changeYear" value="Change Year"/>
		</g:form>
	<br/>
  	<table style = "width : 90%">
		<tr>
			<td>
			</td>
			<td>
				Income
			</td>
			<td>
				Expense
			</td>
			<td>
				Ending Resources
			</td>
		</tr>
		<%--<g:each in = "${1..12}" var="monthSummary">
			<tr>
				<td>${application.monthNames[monthSummary]}</td>
				<td><g:formatNumber number="${1000.00}" type="currency" currencyCode="USD"/></td>
				<td><g:formatNumber number="${1000.00}" type="currency" currencyCode="USD"/></td>
				<td><g:formatNumber number="${1000.00}" type="currency" currencyCode="USD"/></td>
				<td></td>
			</tr>
		</g:each>
		--%><g:each in = "${report}" var="monthSummary">
			<tr>
				<td><g:link action="monthFinancial" params="[month:monthSummary.get(0),year:year]">${application.monthNames[monthSummary.get(0)]}</g:link></td>
				<td><g:formatNumber number="${monthSummary.get(1)}" type="currency" currencyCode="USD"/></td>
				<td><g:formatNumber number="${monthSummary.get(2)}" type="currency" currencyCode="USD"/></td>
				<td><g:formatNumber number="${monthSummary.get(3)}" type="currency" currencyCode="USD"/></td>
				<td></td>
			</tr>
		</g:each>
	</table>
</body>
</html>