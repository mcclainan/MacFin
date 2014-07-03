<g:hiddenField name="budgetItemId" value="${budgetItemInstance?.id}"/>
Create Mode: 
<g:radio name="createMode" value="set" checked="true" onchange="createModeMessage()"/> Set &nbsp;&nbsp;
<g:radio name="createMode" value="single" onchange="createModeMessage()"/> Single<br/>
<br/>
Start Date:
<g:datePicker name="startDate" precision="day" value="${plannedTransactionCommmand?.startDate?:(startDate?:new Date())}"  relativeYears="[0..5]"/><br/>		
<br/>
End Date:&nbsp;
<g:datePicker name="endDate" precision="day" value="${plannedTransactionCommmand?.endDate?:(startDate?.next()?:new Date()+1)}"  relativeYears="[0..5]"/><br/>
<br/>
<g:checkBox name="replaceCurrentSet"/> Replace Current Set<br/>
<br/>
<fieldset class="buttons">
	<g:submitButton name="create" class="save" value="Create Set" />
	<input type="button"  
		   value="Cancel" 
		   onclick="toggleElementVisibility('editBudgetItem','hidden')"/>
</fieldset>