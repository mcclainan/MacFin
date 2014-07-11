<div id="dialogBoxHead">
	<h3>
		<g:if test="${plannedTransactionInstanceList}">
			<g:formatDate date="${plannedTransactionInstanceList[0].plannedTransactionDate}" format="MMM-dd-yyyy"/>
		</g:if> 
	    <g:message code="plannedTransaction.plural" default="Planned Transactions"/> 
	</h3>
</div>
<div id="dialogBoxBody">
	<g:if test="${plannedTransactionInstanceList}">
		<table>
			<tr>
				<th></th>
				<th>Amount</th>
				<th>Category</th>
				<th>Income/Expense</th>
			</tr>
			<g:each in="${plannedTransactionInstanceList}" status="i" var="p">
				<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					<td style="line-height: 1.5em; padding: 0.5em 0.6em; text-align: left; vertical-align: top;">
						<Remote:link updateDiv="dialogBox" action="remoteEdit" id="${p.id}">edit</Remote:link>
					</td>
					<td style="line-height: 1.5em; padding: 0.5em 0.6em; text-align: left; vertical-align: top;">${p.amount}</td>
					<td style="line-height: 1.5em; padding: 0.5em 0.6em; text-align: left; vertical-align: top;">${p.category }</td>
					<td style="line-height: 1.5em; padding: 0.5em 0.6em; text-align: left; vertical-align: top;">${p.category.type}</td>
				</tr>
			</g:each>
		</table>
	</g:if>
	<g:else><h3>None Planned for this day</h3></g:else>
	
</div>
<div id="dialogBoxFooter">
	<input type="button" onclick="toggleDialogBoxVisibility('off','${flash.refresh}')" toggle="on" value="done"/>
</div>