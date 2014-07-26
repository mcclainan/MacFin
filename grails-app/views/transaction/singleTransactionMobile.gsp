
<%@ page import="tracking.Transaction" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'transaction.label', default: 'Transaction')}" />
		<title>Single Transactions</title>
		<style type="text/css">
			body{
				width: 390px;
				min-width: 0;
				
			}
			
			fieldset{
				margin: 0;
				padding: 0;
			}
			
			.fieldcontain{
				margin-top: 0;
				margin-bottom: 1em;
			}
			
			img {
			    border: 0 none;
			    width:325px;
			}
			
			#name,#amount,#notes{
				width: 217px;
			}
			
			#category\.id,#account,#assetLiability{
				width: 232px;
			}
			
		</style>
		
		<g:javascript src="dateSearchCriteria.js" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'search.css')}" type="text/css">
		
		<g:javascript>
			document.getElementById("category.id").focus()
			
			function populateField(id,value){
				document.getElementById(id).value = value;
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
                populateField("category.id",1)
                populateField("account",1)
                populateField("assetLiability","null")
                populateField("id","")
                
                enableElement("create")
                enableElement("update")
                enableElement("delete")
                document.getElementById("transactionDate_day").focus()
			}
			
			
		</g:javascript>
	</head>
	<body>
		<a href="#list-transaction" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="list-transaction" class="content scaffold-list" role="main">
			<h1 >Single Transactions</h1>
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
			
			<div style="padding: 10px;">
					<g:form>
						<fieldset class="form">
							<g:render template="singleForm"/>
						</fieldset>
						<fieldset class="buttons">
							<g:actionSubmit id = "create" action="save" name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" disabled="false" />
							<input type = "button" name="refreshForm" class="refresh" value="Reset Form" onclick = "resetForm()"/>
						</fieldset>
					</g:form>
			</div>
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
	</body>
</html>
