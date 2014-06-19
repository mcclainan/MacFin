<g:applyLayout name="main">
<!DOCTYPE html>
	<head>
		<title><g:layoutTitle default="Grails"/></title>
		<g:layoutHead/>
	</head>
	<body>
		<div id="sideBarRight">
			<h2 style="margin-top: 0em">Meta Category</h2>
			<ul>
				<li><g:link controller="MetaCategory" action="index">List</g:link></li>
				<li><g:link controller="MetaCategory" action="create">Create</g:link></li>
			</ul>
			<h2 style="margin-top: 0em">Category</h2>
			<ul>
				<li><g:link controller="Category" action="index">List</g:link></li>
				<li><g:link controller="Category" action="create">Create</g:link></li>
			</ul>
		</div>
		<div id="maccontent">
		<g:layoutBody/>
		</div>
		<r:layoutResources />
	</body>
</html>
</g:applyLayout>
