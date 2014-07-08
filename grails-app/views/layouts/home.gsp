<g:applyLayout name="main">
<!DOCTYPE html>
	<head>
		<title><g:layoutTitle default="Grails"/></title>
		<g:layoutHead/>
	</head>
	<body>
		<div id="sideBarRight">
			<h2>Tracking</h2>
			<ul>
				<li><g:link controller="transaction" action="singleTransaction">Transactions</g:link></li>
				<li><g:link controller="account">Accounts</g:link></li>
				<li><g:link controller="assetLiability">Assets/Liabilities</g:link>
				</li>
			</ul>
			<h2>Planning</h2>
			<ul>
				<li><g:link controller="budgetItem" action="budgetView"
						params="[staticBudget:'on']">Budget View</g:link></li>
				<li><g:link controller="budgetItem" action="create">New Budget</g:link>
				</li>
			</ul>
			<h2>Reports</h2>
			<ul>
				<li><g:link controller="report" action="financial">Financial</g:link>
				</li>
				<li><g:link controller="report" action="incomeAndExpense">Income and Expense</g:link>
				</li>
			</ul>
			<h2>Records Maintenance</h2>
			<ul>
				<li><g:link controller="metaCategory">Meta Category</g:link>
				</li>
				<li><g:link controller="category">Category</g:link>
				</li>
			</ul>
		</div>
		
		<div id="maccontent">
		<g:layoutBody/>
		</div>
		<r:layoutResources />
	</body>
</html>
</g:applyLayout>