<%@ page import="planning.BudgetItem" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="planning">
<g:set var="entityName" value="${message(code: 'budgetItem.label', default: 'BudgetItem')}" />
<title>Budget View</title>
<style type="text/css">
	td{line-height: .5em;}
	th{
		text-align: center;
		vertical-align: bottom;
	}
</style>
<SCRIPT TYPE="text/javascript">
	<!--
	function popup(mylink, windowname)
	{
	if (! window.focus)return true;
	var href;
	if (typeof(mylink) == 'string')
	   href=mylink;
	else
	   href=mylink.href;
	   window.open(href, windowname, 'width=400,height=200,scrollbars=yes');
	return false;
	}
	//-->
</SCRIPT>
</head>
<body>
	<div id="primaryContentContainer">
		<div id="primaryContent">
			<g:form action = "view">
			<div style = "width:100%;height:60px;">
			<h1 style = "margin-left: 10px; width:50%; float:left;">${application.monthNames[budgetView.month]} ${budgetView.year} Budget</h1>
				<div style="float:right;margin:15px">
					Year <g:select name="year" from="${[2011,2012,2013,2014,2015]}" value = "${year}"/> 
					Month <g:select name="month" from="${application.monthNames}" optionKey="key" optionValue="value" value = "${budgetView.month}"/>
					<g:submitButton name="Refresh"/>
				</div>
				
			</div>
			</g:form>
			<div style = "margin : 10px; width:97.25% ;">
				<div style="width:28em; float:left;border: solid;border-width: 10px; border-style: outset; padding:5px; margin-bottom: 10px">
					<h3 style="text-align: center;">Year Overview</h3><br/>
					<table>
						<thead>
							<tr>
								<th style = "font-weight: bold;">
									Month								
								</th>
								<th font-weight: bold;">
									Income
								</th>
								<th font-weight: bold;">
									Expense
								</th>
								<th font-weight: bold;">
									Ending Resources
								</th>
							</tr>
						</thead>
						<tbody>
							<g:each var="monthOverView"	in="${budgetView.yearOverview}">
								<tr>
									<td style="line-height: .5em;">
										${application.monthNames[monthOverView.month]}
									</td>
									<td style="line-height: .5em; text-align: right;">
										<g:formatNumber number="${Math.abs(monthOverView.incomeTotal?:0)}" type="currency" currencyCode="USD"/>
									</td>
									<td style="line-height: .5em; text-align: right;">
										<g:formatNumber number="${Math.abs(monthOverView.expenseTotal?:0)}" type="currency" currencyCode="USD"/>
									</td>
									<td style="line-height: .5em; text-align: right;">
										<g:formatNumber number="${monthOverView.endingTotal}" type="currency" currencyCode="USD"/>
									</td>
								<tr/>
							</g:each>
						</tbody>
					</table>
				</div>
				<div style="width: 30em; float:right; margin-bottom: 10px">
					<div style="width: 95%; border: solid; border-width: 10px; border-style: outset; padding:5px;  margin-bottom: 10px; ">
						<h3 style = "margin-bottom: 10px; text-align: center;">Income</h3>
						<g:each in="${budgetView.monthBreakdown.incomeBreakdown}" var = "metaCategory">
							<h4>${metaCategory.key}</h4>
							<table>
								<g:each in="${metaCategory.value}" var = "category">
									<tr>
										<td style = "width: 20em">
											<g:link controller="budgetItem" action="showByCategoryMonthAndYear" params="[month:month,year:year,name:category[0]]" target="_blank">
												${category[0]}
											</g:link>
										</td>
										<td style = "text-align: right; width:8em;">
											<g:formatNumber number="${Math.abs(category[1]?:0)}" type="currency" currencyCode="USD"/>
										</td>
									</tr>									
								</g:each>
							</table>
						</g:each>
					</div>
					<div style="width: 95%; border: solid; border-width: 10px; border-style: outset; padding:5px;  margin-bottom: 10px; ">
						<h3 style = "margin-bottom: 10px; text-align: center;">Expense</h3>
						<g:each in="${budgetView.monthBreakdown.expenseBreakdown}" var = "metaCategory">
							<h4>${metaCategory.key}</h4>
							<table>
								<g:each in="${metaCategory.value}" var = "category">
									<tr>
										<td style = "width: 20em">
											<g:link controller="budgetItem" action="showByCategoryMonthAndYear" params="[month:month,year:year,name:category[0]]" target="_blank">
												${category[0]}
											</g:link>
										</td>
										<td style = "text-align: right;  width:8em;">
											<g:formatNumber number="${Math.abs(category[1]?:0)}" type="currency" currencyCode="USD"/>
										</td>
									</tr>									
								</g:each>
							</table>
						</g:each>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>