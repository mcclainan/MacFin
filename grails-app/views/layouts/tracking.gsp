<g:applyLayout name="main">
<!DOCTYPE html>
	<head>
		<g:if test="${params.action != 'reconciliation'}">
			<g:javascript library="jQuery"/>
		</g:if>
		<title><g:layoutTitle default="Grails"/></title>
		<g:layoutHead/>
	</head>
	<body>
		<div id="sideBarRight">
			<h2 style="margin-top: 0em">Transactions</h2>
			<ul>
				<li><g:link controller="transaction" action="index">Single</g:link></li>
				<li><g:link controller="transaction" action="combinationTransaction">Combination</g:link></li>
				<li><g:link controller="transaction" action="accountTransfer">Account Transfer</g:link></li>
				<li><g:link controller="transaction" action="reconciliation">Reconciliation</g:link></li>
			</ul>
			<h2 style="margin-top: 0em">Bank Records</h2>
			<ul>
				<li><g:link controller="bankRecord" action="index">List</g:link></li>
				<li><g:link controller="bankRecord" action="loadFile">Load From File</g:link></li>
			</ul>
			<h2 style="margin-top: 0em">Account</h2>
			<ul>
				<li><g:link controller="account" action="index">List</g:link></li>
				<li><g:link controller="account" action="create">Create</g:link></li>
			</ul>
			<h2 style="margin-top: 0em">Assets/Liabilities</h2>
			<ul>
				<li><g:link controller="assetLiability" action="index">List</g:link></li>
				<li><g:link controller="assetLiability" action="create">Create</g:link></li>
			</ul>
		</div>
		
		<div id="maccontent">
		<g:layoutBody/>
		</div>
		<r:layoutResources />
	</body>
</html>
</g:applyLayout>