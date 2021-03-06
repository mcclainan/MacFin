<%@ page import="tracking.Transaction" %>
<g:hiddenField name="id" value="${transactionInstance.id}"/>
	<label for="transactionDate">
		<g:message code="transaction.transactionDate.label" default="Transaction Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="transactionDate" precision="day"  value="${transactionInstance?.transactionDate}" />


	<label for="category">
		<g:message code="transaction.category.label" default="Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:if test="${mobile}">
		<g:select id="category" name="category.id" from="${category.Category.findAllWhere(active:'Y',displayOnMobile:'Y',[sort:"name"])}" optionKey="id" required="" value="${transactionInstance?.category?.id}" class="category"/>
	</g:if>
	<g:else>
		<g:select id="category" name="category.id" from="${category.Category.findAllByActive("Y",[sort:"name"])}" optionKey="id" required="" value="${transactionInstance?.category?.id}" class="category"/>
	</g:else>

	<label for="name">
		<g:message code="transaction.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${transactionInstance?.name}"/>

	<label for="amount">
		<g:message code="transaction.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="amount" step="any" value="${fieldValue(bean: transactionInstance, field: 'amount')}" required=""/>

	<label for="notes">
		<g:message code="transaction.notes.label" default="Notes" />
		
	</label>
	<g:textArea name="notes" cols="40" rows="5" maxlength="255" value="${transactionInstance?.notes}"/>

	<label for="account">
		<g:message code="transaction.account.label" default="Account" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="account" name="account.id" from="${tracking.Account.findAllByActive("Y")}" optionKey="id" required="" value="${transactionInstance?.account?.id}" class="many-to-one"/>

</div>



