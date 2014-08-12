<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="reports"/>
<g:javascript>
	function displayNotes(id){
		var newHtml = "<h2>Notes</h2><br/>"
		newHtml += document.getElementById(id).innerHTML
		newHtml += '<br/><br/> <input type="button" onlclick="toggleDialogBoxVisibility('on',false)">'
		document.getElementById("dialogBox").style.visibility = "visible"
	}
</g:javascript>
</head>
<body>
	<h1>Transactions for ${categoryName} in the month of ${application.monthNames[month]} ${year}</h1>
	<br/>
	<g:form action="categoryForMonth">
		<g:select name="month" from="${application.monthNames}" optionKey="key" optionValue="value" value="${month}"/>
		<g:select name="year" from="${2012..2020 }" value="${year}"/>
		<g:hiddenField name="categoryName" value="${categoryName}"/>
		<g:submitButton name="change" value="Refresh"/>
		<g:actionSubmit value="Done" action="monthFinancial"/>
	</g:form>
	
	<div class="singleTable">
		<table>
			<thead>
				<tr>

					<th><g:message code="transaction.transactionDate.label"
							default="Date" /></th>


					<g:sortableColumn property="name"
						title="${message(code: 'transaction.name.label', default: 'Name')}" />

					<g:sortableColumn property="amount"
						title="${message(code: 'transaction.amount.label', default: 'Amount')}" />
						
					<th><g:message code="transaction.account.label"
							default="Account" /></th>
					<th><g:message code="transaction.notes.label"
							default="Notes" /></th>
				</tr>
			</thead>
			<tbody>
				<g:each in="${transactionInstanceList}" status="i"
					var="transactionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

						<td><g:formatDate
								date="${transactionInstance.transactionDate}"
								format="MM/dd/yyyy" /></td>

						<td>
							${fieldValue(bean: transactionInstance, field: "name")}
						</td>

						<td><g:formatNumber
								number="${fieldValue(bean: transactionInstance, field: "amount")}"
								format="###,###.00" /></td>
						
						<td>
							${fieldValue(bean: transactionInstance, field: "account")}
						</td>
						<td id="notes${transactionInstance.id}"  onclick="diplayNotes('notes${transactionInstance.id}')">
							${fieldValue(bean: transactionInstance, field: "notes")}
						</td>
					</tr>
				</g:each>
			</tbody>
		</table>
		<div class="pagination">
			<g:paginate total="${transactionInstanceCount ?: 0}" params="[month:month, year:year,categoryName:categoryName]"/>
		</div>
	</div>
</body>
</html>