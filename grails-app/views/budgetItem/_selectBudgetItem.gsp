<g:form action="change">
	<g:hiddenField name="id" value="${budgetItemInstance.id}"/>
	<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'year', 'error')} required">
		<label for="year">
			<g:message code="budgetItem.year.label" default="Year" />
			<span class="required-indicator">*</span>
		</label>
		<g:field name="year" type="number" min="2011" max="2020" value="${budgetItemInstance?.year}" required=""/>
	
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'month', 'error')} required">
		<label for="month">
			<g:message code="budgetItem.month.label" default="Month" />
			<span class="required-indicator">*</span>
		</label>
		<g:field name="month" type="number" min="1" max="12" value="${budgetItemInstance?.month}" required=""/>
	
	</div>
	
	<div class="fieldcontain ${hasErrors(bean: budgetItemInstance, field: 'category', 'error')} required">
		<label for="category">
			<g:message code="budgetItem.category.label" default="Category" />
			<span class="required-indicator">*</span>
		</label>
		<g:select id="category" name="category.id" from="${category.Category.list()}" optionKey="id" required="" value="${budgetItemInstance?.category?.id}" class="many-to-one"/>
	</div>
	<br/>
	<fieldset class="buttons">
		<g:submitButton name="Change" />
		<input type="button"  
					value="Cancel" 
					onclick="toggleElementVisibility('changeBudgetItem','hidden')"/>
	</fieldset>
</g:form>