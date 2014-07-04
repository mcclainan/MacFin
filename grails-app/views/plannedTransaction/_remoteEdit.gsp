<%@ page import="planning.PlannedTransaction" %>
<div id="dialogBoxHead">
	<h3>
		Edit Planned Transaction
	</h3>
</div>
<div id="dialogBoxBody">
	<g:form controller="plannedTransaction">
		<g:hasErrors bean="${plannedTransactionInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${plannedTransactionInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
		</g:hasErrors>
		<fieldset class="form">
			<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'plannedTransactionDate', 'error')} required">
				<label for="plannedTransactionDate">
					<g:message code="plannedTransaction.plannedTransactionDate.label" default="Planned Transaction Date" />
				</label>
				<g:datePicker name="plannedTransactionDate" precision="day"  value="${plannedTransactionInstance?.plannedTransactionDate}"  />
			
			</div>
			
			<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'amount', 'error')} required">
				<label for="amount">
					<g:message code="plannedTransaction.amount.label" default="Amount" />
				</label>
				<g:field type="text" name="amount" value="${fieldValue(bean: plannedTransactionInstance, field: 'amount')}" required=""/>
			
			</div>
			
			<div class="fieldcontain ${hasErrors(bean: plannedTransactionInstance, field: 'rolling', 'error')} ">
				<label for="rolling">
					<g:message code="plannedTransaction.rolling.label" default="Rolling" />
					
				</label>
				<g:select name="rolling" from="${plannedTransactionInstance.constraints.rolling.inList}" value="${plannedTransactionInstance?.rolling}" valueMessagePrefix="plannedTransaction.rolling" noSelection="['': '']"/>
			</div>
		</fieldset>
		<fieldset class="buttons">
			<Remote:submitButton updateDiv="dialogBox" controller="plannedTransaction" action="remoteUpdate" value="Update"/>
			<Remote:submitButton updateDiv="dialogBox" controller="plannedTransaction" action="remoteDelete" value="Delete"/>
		</fieldset>
		<g:hiddenField name="id" value="${plannedTransactionInstance.id}"/>
	</g:form>
</div>
<div id="dialogBoxFooter">
	<br/>
	<input type="button" onclick="toggleDialogBoxVisibility('off','${flash.refresh}')" toggle="on" value="done"/>
</div>

