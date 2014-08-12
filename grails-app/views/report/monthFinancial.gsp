<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="reports"/>
</head>
<body>
	<h1>Financial Report for ${application.monthNames[month]}</h1>
	<br/>
	<g:form action="monthFinancial">
		<g:select name="month" from="${application.monthNames}" optionKey="key" optionValue="value" value="${month}"/>
		<g:select name="year" from="${2012..2020 }" value="${year}"/>
		<g:submitButton name="change" value="Refresh"/>
		<g:actionSubmit value="Done" action="index"/>
	</g:form>
	
	<div style="margin:1em 8em; border:solid; border-style:outset; border-width: 10px;">
		<h2 style="font-size: 2em;">Income</h2>
		<div style = "height:78.7% ; padding-left:15px; padding-top:10px ">
			<g:each in="${incomeBreakdown}" var="metaCategory">
				<span style="font-weight: bold; font-size: 17px;">${metaCategory.key}</span><br/>
				<g:each in="${metaCategory.value}" var="category">
					<div style="width:50%; margin-left: 15px; float:left">
						<g:link action="categoryForMonth" params="[month:month,year:year,categoryName:category.get(0)]">
							${category.get(0)}
						</g:link>
					</div>
					<div style="width:30%; margin-left: 15px; float:right">
					   <g:formatNumber number="${category.get(1)}" type="currency" currencyCode="USD"/>
					</div>
					<br/>
				</g:each>
				<br/>
			</g:each>
		</div>
	</div>
	<div  style="margin:1em 8em; border:solid; border-style:outset;  border-width: 10px;">
		<h2 style="font-size: 2em;">Expense</h2>
		<div style = "width:97%;height:89.5% ; padding-left:15px; padding-top: 10px">
			<g:each in="${expenseBreakdown}" var="metaCategory">
				<span style="font-weight: bold; font-size: 17px;">${metaCategory.key}</span><br/>
				<g:each in="${metaCategory.value}" var="category">
					<div style="width:50%; margin-left: 15px; float:left">
						<g:link action="categoryForMonth" params="[month:month,year:year,categoryName:category.get(0)]">
							${category.get(0)}
						</g:link>
					</div>
					<div style="width:30%; margin-left: 15px; float:right">
					   <g:formatNumber number="${category.get(1)}" type="currency" currencyCode="USD"/>
					</div>
					<br/>
				</g:each>
				<br/>
			</g:each>
		</div>
	</div>
</body>
</html>