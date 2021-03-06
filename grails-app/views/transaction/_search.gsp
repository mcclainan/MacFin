<%@ page import="tracking.Transaction" %>

<h3>Search Transactions</h3>
<g:if test="${flash.searchErrors}">
<ul class="errors" role="alert">
	<g:each in="${flash.searchErrors}" var="error">
		<li>${error.value}</li>
	</g:each>
</ul>
</g:if>
<g:form action="search">
	<table>
		<tbody>
			<tr>
				<td colspan="2">
					Date Search Options <g:select name="dateSearchOption" from="${['By Month','By Date','By Date Range']}" noSelection="${['null':'Select One...']}" onchange = "showCriteria('dateSearchOption')"/>
				</td> 
			</tr>
			<tr id = "byMonth" class = "invisible">
				<td colspan="2" style="padding-left: 2.5em">
					Month <g:datePicker name="searchMonth" precision="month" value="${new Date()}"/>
				</td> 
			</tr>
			<tr id = "byDate" class = "invisible">
				<td colspan="2"  style="padding-left:  2.5em">
					Date <g:datePicker name="searchDate" precision="day" value="${new Date()}"/>
				</td> 
			</tr>
			<tr id = "byDateRange" class = "invisible">
				<td colspan="3"  style="padding-left:  2.5em">
					From <g:datePicker name="startDate" precision="day" value="${new Date()}"/> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To <g:datePicker name="endDate" precision="day" value="${new Date()}"/>
				</td> 
			</tr>
			<tr>
				<td>
					Category <g:select name="searchCategoryId" from="${category.Category.list()}" optionKey="id" optionValue="name" noSelection="${['null':'Select One...']}"/>
				</td>
				<td>
					Name <g:textField name="searchName"/>
				</td>
			</tr>
			<tr>
				<td> 
					Amount <g:textField name="searchAmount"/>
				</td>
				<td>
					Account <g:select id="searchAccountId" name="searchAccountId" from="${tracking.Account.list()}" optionKey="id" required="" value="${transactionInstance?.account?.id}" class="many-to-one" noSelection="${['null':'Select One...']}"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					Asset Liability <g:select id="searchAssetLiabilityId" name="searchAssetLiabilityId" from="${assetLiability.AssetLiability.list()}" optionKey="id" value="${transactionInstance?.assetLiability?.id}" class="many-to-one" noSelection="${['null':'Select One...']}"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<g:submitButton name="search" style="margin-right:1em"/> 
					<input type="button" class="searchButtons" value="Reset"  onclick="collapseAllDates();resetSearch();" style="margin-right:1em"/> 
					<input type="button" class="searchButtons" value="Close Search" onclick="collapseAllDates();toggleSearch('off');resetSearch();" style = ""/> 
				</td>
			</tr>
		</tbody>
	</table>
</g:form>
