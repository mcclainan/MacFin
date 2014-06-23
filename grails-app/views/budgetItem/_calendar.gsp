
<table class="calendarTable">
	<tr class="calendarTableHeaderDate">
		<td COLSPAN="7" class="calendarHead"><B> 
			${utilities.Months.values()[(cashFlowMonth.month - 1)].name} ${cashFlowMonth.year}
		</B></td>
	</tr>

	<g:if
		test="${params.controller=='budgetItem' && params.action=='show'}">
		<tr class="calendarTableTitle">
			<td COLSPAN="7" class="calendarHead"><I><g:message
						code="plannedTransaction.label.plural" /> for ${budgetItemInstance.category }
			</I></td>
		</tr>
	</g:if>
	<tr class="calendarTableDayHeaders">
		<th class="calendarTableDayHeader">Sun</th>
		<th class="calendarTableDayHeader">Mon</th>
		<th class="calendarTableDayHeader">Tue</th>
		<th class="calendarTableDayHeader">Wed</th>
		<th class="calendarTableDayHeader">Thu</th>
		<th class="calendarTableDayHeader">Fri</th>
		<th class="calendarTableDayHeader">Sat</th>
	</tr>
	<g:set var="balance" value="${tracking.Account.calcSumByCash().list().get(0)}" />
	<g:each in="${cashFlowMonth.cashFlowWeekList}" var="cashFlowWeek">
		<tr class="calendarTableWeek">
			<g:each in="${cashFlowWeek.cashFlowDayList}" var="cashFlowDay">
				<td class="calendarTableDay"">
					<g:if test="${cashFlowDay.day}">
						<span style="color:blue; background-color: #66a0be;">
							${cashFlowDay.day}<br/>
						</span>
					</g:if>
					<g:if test="${cashFlowDay.income}">
						<span style="color:green;">
							<g:formatNumber number="${cashFlowDay.income}" format="#,##0.00" />
						</span><br/>
					</g:if>
					<g:if test="${cashFlowDay.expense}">
						<span style="color:red">
							<g:formatNumber number="${cashFlowDay.expense}" format="#,##0.00" />
						</span><br/>
					</g:if>
					<g:if test="${cashFlowDay.amount}">
						<g:formatNumber number="${cashFlowDay.amount}" format="#,##0.00" /><br/>
					</g:if>
					<g:if test="${cashFlowDay.isCurrentDay}">
						<g:set var="balance" value="${balance+=cashFlowDay.ignoreAmount}"/>
					</g:if>
					<g:if test="${params.controller!='budgetItem' && cashFlowDay.day}">
						<div style="font-weight: bold;">
							<g:if test="${balance>0}">
								<span style="color:green">
							</g:if>	
							<g:elseif test="${balance<0}">
								<span style="color:red">
							</g:elseif>
							<g:else>
								<span style="color:black">
							</g:else>
								<g:formatNumber number="${balance+=(cashFlowDay.income-cashFlowDay.expense)}" type="currency" currencyCode="USD"/>
							</span>
						</div>
					</g:if> 
				</td>
			</g:each>
		</tr>
	</g:each>

</table>
