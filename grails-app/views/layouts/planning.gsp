<g:applyLayout name="main">
<!DOCTYPE html>
	<head>
		<title><g:layoutTitle default="Grails"/></title>
		<g:layoutHead/>
	</head>
	<body>
		<div id="sideBarRight">
			<h2 style="margin-top: 0em">Budget</h2>
			<ul>
				<li><g:link controller="budgetItem" action="view">View</g:link></li>
				<li><g:link controller="budgetItem" action="create">Create</g:link></li>
			</ul>
			<h2 style="margin-top: 0em">Planned Transaction</h2>
			<ul>
				<li><g:link controller="plannedTransaction" action="index">List</g:link></li>
				<li><g:link controller="plannedTransaction" action="cashFlowCalendar">Cash Flow Calendar</g:link></li>
			</ul>
		</div>
		<div id="maccontent">
		<g:layoutBody/>
		</div>
		<r:layoutResources />
	</body>
</html>
</g:applyLayout>