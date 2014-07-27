<g:applyLayout name="main">
<!DOCTYPE html>
	<head>
		<title><g:layoutTitle default="Grails"/></title>
		<g:layoutHead/>
	</head>
	<body>
		<div id="sideBarRight">
			<h2 style="margin-top: 0em">Financial Reports</h2>
			<ul>
				<li><g:link controller="report" action="index">Full Year Summary</g:link></li>
				<li><g:link controller="report" action="financialMonth">Full Month</g:link></li>
			</ul>
			<h2 style="margin-top: 0em">Income/Expense Reports</h2>
			<ul>
				<li><g:link controller="report" action="monthByCategory">Month by Category</g:link></li>
			</ul>
		</div>
		<div id="maccontent">
			<g:layoutBody/>
		</div>
		<r:layoutResources />
	</body>
</html>
</g:applyLayout>