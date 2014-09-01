<g:form>
	<fieldset class="form">
		<g:render template="singleForm" />
	</fieldset>
	<fieldset class="buttons">
		<g:actionSubmit id="create" action="saveFromRecon" name="create" class="save"
			value="${message(code: 'default.button.create.label', default: 'Create')}"
			disabled="false" />
	</fieldset>
	<g:hiddenField name="verified" value="Y"/>
	<g:hiddenField name="bankRecordId" value="${bankRecordId}"/>
	<g:hiddenField name="recon" value="true"/>
</g:form>