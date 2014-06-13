<%@ page import="assetLiability.AssetLiabilityClass" %>



<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="assetLiabilityClass.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${assetLiabilityClassInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onSale', 'error')} required">
	<label for="onSale">
		<g:message code="assetLiabilityClass.onSale.label" default="On Sale" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="onSale" type="number" value="${assetLiabilityClassInstance.onSale}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onPurchase', 'error')} required">
	<label for="onPurchase">
		<g:message code="assetLiabilityClass.onPurchase.label" default="On Purchase" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="onPurchase" type="number" value="${assetLiabilityClassInstance.onPurchase}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onProceedes', 'error')} required">
	<label for="onProceedes">
		<g:message code="assetLiabilityClass.onProceedes.label" default="On Proceedes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="onProceedes" type="number" value="${assetLiabilityClassInstance.onProceedes}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onPayment', 'error')} required">
	<label for="onPayment">
		<g:message code="assetLiabilityClass.onPayment.label" default="On Payment" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="onPayment" type="number" value="${assetLiabilityClassInstance.onPayment}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onInterest', 'error')} required">
	<label for="onInterest">
		<g:message code="assetLiabilityClass.onInterest.label" default="On Interest" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="onInterest" type="number" value="${assetLiabilityClassInstance.onInterest}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onAppreciation', 'error')} required">
	<label for="onAppreciation">
		<g:message code="assetLiabilityClass.onAppreciation.label" default="On Appreciation" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="onAppreciation" type="number" value="${assetLiabilityClassInstance.onAppreciation}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onDepreciation', 'error')} required">
	<label for="onDepreciation">
		<g:message code="assetLiabilityClass.onDepreciation.label" default="On Depreciation" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="onDepreciation" type="number" value="${assetLiabilityClassInstance.onDepreciation}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: assetLiabilityClassInstance, field: 'onUse', 'error')} required">
	<label for="onUse">
		<g:message code="assetLiabilityClass.onUse.label" default="On Use" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="onUse" type="number" value="${assetLiabilityClassInstance.onUse}" required=""/>

</div>

