
<%@ page import="tracking.Transaction"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="tracking">
<g:set var="entityName"
	value="${message(code: 'singleTransaction.label', default: 'Transaction')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>

<link rel="stylesheet" href="${resource(dir: 'css', file: 'singleTransaction.css')}" type="text/css">
<style type="text/css">
	.searchCriteria{
		width: 41em; 
		border: solid; 
		margin-left: 11em;
		z-index: 1;
		position:absolute; 
		opacity:100; 
		background-color: #EFEFEF; 
		padding: 1em; 
		visibility: hidden;
	}
</style>
<g:javascript src="dateSearchCriteria.js" />
<link rel="stylesheet" href="${resource(dir: 'css', file: 'search.css')}" type="text/css">
<g:javascript>
			document.getElementById("transactionDate_day").focus()
			
				function populateForm(transactionId){
				populateField("transactionDate_day",document.getElementById("date_day" + transactionId).value)
				populateField("transactionDate_month",document.getElementById("date_month" + transactionId).value)
				populateField("transactionDate_year",document.getElementById("date_year" + transactionId).value)
                populateField("name",document.getElementById("name" + transactionId).value)
                populateField("amount",document.getElementById("amount" + transactionId).value)
                populateField("notes","")
                populateField("notes",document.getElementById("notes" + transactionId).value)
                populateField("category",document.getElementById("category.id" + transactionId).value)
                populateField("account",document.getElementById("account.id" + transactionId).value)
                populateField("id",transactionId)
			}
			function populateField(id,value){
				document.getElementById(id).value = value;
			}
			function disableElement(id){
				var element = document.getElementById(id)
				element.disabled = "disabled"
			}
			function enableElement(id){
				var element = document.getElementById(id)
				element.disabled = false
			}
			
			function resetForm(){
				var date = ${new Date().format("dd").toInteger()}
				var month = ${new Date().format("MM").toInteger()}
				var year = ${new Date().format("yyyy").toInteger()}
				
				populateField("transactionDate_day", date)
				populateField("transactionDate_month",month)
				populateField("transactionDate_year",year)
                populateField("name","")
                populateField("amount","")
                populateField("notes","")
                populateField("category",1)
                populateField("account",1)
                populateField("id","")
                
                enableElement("create")
                disableElement("update")
                disableElement("delete")
                document.getElementById("transactionDate_day").focus()
			}
			
			function resetSearch(){
				populateField("dateSearchOption", "null")
				populateField("searchCategoryId","null")
				populateField("searchName","")
				populateField("searchAmount","")
                populateField("searchAccountId","null")
			}
			
			function toggleSearch(action){
				if(action == "on"){
					document.getElementById("searchForm").style.visibility = "visible"
				}else{
					document.getElementById("searchForm").style.visibility = "hidden"
				}
			}
			
			function centerSearch(){
				var width = window.innerWidth
				var height = document.body.clientHeight
				var top = (height/2) - 150
				var left = (width/2) - 350
				document.getElementById("searchForm").style.top = top + "px"
				document.getElementById("searchForm").style.left = left + "px"
			} 
			
			function collapseAllDates(){
				document.getElementById("byMonth").style.visibility = "collapse"
				document.getElementById("byDate").style.visibility = "collapse"
				document.getElementById("byDateRange").style.visibility ="collapse"
			}
</g:javascript>
</head>
<body>
	<a href="#list-transaction" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>
	<div id="list-transaction" class="content scaffold-list" role="main">
		<h1>
			<g:message code="default.list.label" args="[entityName]" />
		</h1>
		<div id="searchForm" 
		 class="searchCriteria">
			<g:render template="search"/>
		</div>
		<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
		</g:if>
		<g:hasErrors bean="${transactionInstance}">
		<ul class="errors" role="alert">
			<g:eachError bean="${transactionInstance}" var="error">
			<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
			</g:eachError>
		</ul>
		</g:hasErrors>
		<div class="singleMain">
			<div class="singleForm">
				<g:form url="[resource:transactionInstance, action:'save']" >
					<fieldset class="form">
						<g:render template="singleForm"/>
					</fieldset>
					<fieldset class="buttons">
						<g:actionSubmit id="create" action="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
						<g:actionSubmit id="update" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" disabled = "disabled"/>
						<g:actionSubmit id="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" disabled = "disabled"/>
						<input type="button" id="search" value="Search" onclick="toggleSearch('on')"/>
						<input type = "button" name="refreshForm" value="Reset " onclick = "resetForm()"/>
					</fieldset>
				</g:form>
			</div>
			<div class="singleTable">
				<table>
					<thead>
						<tr>
	
							<th><g:message code="transaction.transactionDate.label"
									default="Date" /></th>
	
							<th><g:message code="transaction.category.label"
									default="Category" /></th>
	
							<g:sortableColumn property="name"
								title="${message(code: 'transaction.name.label', default: 'Name')}" />
	
							<g:sortableColumn property="amount"
								title="${message(code: 'transaction.amount.label', default: 'Amount')}" />
						</tr>
					</thead>
					<tbody>
						<g:each in="${transactionInstanceList}" status="i"
							var="transactionInstance">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}"onclick="populateForm('${transactionInstance.id}'); disableElement('create'); enableElement('delete'); enableElement('update'); ">
	
								<td><g:formatDate
										date="${transactionInstance.transactionDate}"
										format="MM/dd/yyyy" /></td>
	
								<td>
									${fieldValue(bean: transactionInstance, field: "category")}
								</td>
	
								<td>
									${fieldValue(bean: transactionInstance, field: "name")}
								</td>
	
								<td><g:formatNumber
										number="${fieldValue(bean: transactionInstance, field: "amount")}"
										format="####.00" /></td>
							</tr>
									<g:hiddenField name="tableField${transactionInstance.id}" id = "date_day${transactionInstance.id}" value = "${transactionInstance.transactionDate.format('dd').toInteger()}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "date_month${transactionInstance.id}" value = "${transactionInstance.transactionDate.format('MM').toInteger()}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "date_year${transactionInstance.id}" value = "${transactionInstance.transactionDate.format('yyyy').toInteger()}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "name${transactionInstance.id}" value = "${ transactionInstance.name}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "amount${transactionInstance.id}" value = "${transactionInstance.amount}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "notes${transactionInstance.id}" value = "${ transactionInstance.notes}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "category.id${transactionInstance.id}" value = "${transactionInstance.category?.id}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "account.id${transactionInstance.id}" value = "${transactionInstance.account?.id}"/>
				                	<g:hiddenField name="tableField${transactionInstance.id}" id = "assetLiability.id${transactionInstance.id}" value = "${transactionInstance.assetLiability?.id}"/>
						</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<g:paginate total="${transactionInstanceCount ?: 0}" params="${searchParams}"/>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
