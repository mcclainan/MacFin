<table BORDER=3 CELLSPACING=3 CELLPADDING=3>
	<tr>
		<td COLSPAN="7"  class="calendarHead"><B>${utilities.Months.values()[budgetItemInstance.month].name} ${budgetItemInstance.year}</B></td>
	</tr>
	
	<g:if test="${params.controller=='budgetItem' && params.action=='show'}">
		<tr >
			<td COLSPAN="7"  class="calendarHead"><I><g:message code="plannedTransaction.label.plural"/> for ${budgetItemInstance.category } </I></td>
		</tr>
	</g:if>
	<tr>
		<th style="text-align: center;">Sun</th>
		<th style="text-align: center;">Mon</th>
		<th style="text-align: center;">Tue</th>
		<th style="text-align: center;">Wed</th>
		<th style="text-align: center;">Thu</th>
		<th style="text-align: center;">Fri</th>
		<th style="text-align: center;">Sat</th>
	</tr>
	<g:set var="dates" value="${1}"/>
	<g:set var="balance" value="${tracking.Account.calcSumByCash().list().get(0)}"/>
	<tr>
		<g:if test="${startDay}">
			<g:each in="${1..startDay}">
				<td style="text-align: left;"></td>
			</g:each>
		</g:if>
		<g:each in="${1..(7-startDay)}">
			<td style="text-align: left;">
				<g:if test="${params.controller=='plannedTransaction' && params.action=='cashFlowCalendar'}">
					${dates++}<br/>+100<br/>-50<br/>Bal ${balance-=50}
				</g:if>
				<g:else>
					$100
				</g:else>
			</td>
		</g:each>
	</tr>
	<g:each in="${1..4}">
		<tr>
			<g:each in="${1..7}">
				<td style="text-align: left;">${dates++}</td>
			</g:each>
		</tr>
	</g:each>
	
</table>
