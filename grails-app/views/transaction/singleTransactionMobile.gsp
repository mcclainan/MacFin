<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Ninestars bootstrap 3 one page template</title>

    <!-- Bootstrap Core CSS -->
    <link href="${resource(dir: 'assets/css', file: 'bootstrap.min.css')}" rel="stylesheet" type="text/css">

    <!-- Fonts -->
    <link href="${resource(dir: 'assets/font-awesome/css', file: 'font-awesome.min.css')}" rel="stylesheet" type="text/css">
	<link href="${resource(dir: 'assets/css/', file: 'nivo-lightbox.css')}" rel="stylesheet" />
	<link href="${resource(dir: 'assets/css/nivo-lightbox-theme/default', file: 'default.css')}" rel="stylesheet" type="text/css" />
	<link href="${resource(dir: 'assets/css', file: 'animate.css')}" rel="stylesheet" />
    <!-- Squad theme CSS -->
    <link href="${resource(dir: 'assets/css', file: 'style.css')}" rel="stylesheet">
	<link href="${resource(dir: 'assets/color', file: 'default.css')}" rel="stylesheet">

</head>

<body data-spy="scroll">

<div class="container">
			<ul id="gn-menu" class="gn-menu-main">

				<li><g:link uri="/"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Grails" style="height: 5em;"/></g:link></li>

			</ul>
	</div>

	<!-- Section: intro -->


	<!-- Section: contact -->
    <section id="contact" class="home-section text-center">
		<div class="heading-contact marginbot-50">
			<div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2">
                        <div class="section-heading">
                        <h2 style="font-size: 1.5em">Single Transaction</h2>
                        </div>
                        <g:if test="${flash.message}">
                            <div class="message" role="status">${flash.message}</div>
                        </g:if>
                        <g:eachError bean="${transactionInstance}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </div>
                </div>
			</div>
		</div>
		<div class="container">

    <div class="row">
        <div class="col-lg-8 col-md-offset-2">
            <div class="boxed-grey">
                <g:form url="[resource:transactionInstance, action:'save']" >
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="transactionDate">
                                <g:message code="transaction.transactionDate.label" default="Transaction Date" />
                            </label>
                            <g:datePicker class="form-control" name="transactionDate" precision="day"  value="${transactionInstance?.transactionDate}" />
                        </div>
                    	<div class="form-group">
                            <label for="category">
                                <g:message code="transaction.category.label" default="Category" />
                                <span class="required-indicator">*</span>
                            </label>
                            <g:if test="${mobile}">
                                <g:select id="category" name="category.id" from="${category.Category.findAllWhere(active:'Y',displayOnMobile:'Y',[sort:"name"])}" optionKey="id" required="" value="${transactionInstance?.category?.id}" class="form-control"/>
                            </g:if>
                            <g:else>
                                <g:select id="category" name="category.id" from="${category.Category.findAllByActive("Y",[sort:"name"])}" optionKey="id" required="" value="${transactionInstance?.category?.id}" class="form-control"/>
                            </g:else>
                        </div>
                        <div class="form-group">
                            <label for="name">
                                <g:message code="transaction.name.label" default="Name" />
                                <span class="required-indicator">*</span>
                            </label>
                            <g:textField name="name" required="" value="${transactionInstance?.name}" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label for="amount">
                                <g:message code="transaction.amount.label" default="Amount" />
                            </label>
                            <div class="input-group">
                                <span class="input-group-addon">$</span>
                                </span>
                                <g:field type="number" name="amount" step="any" value="${fieldValue(bean: transactionInstance, field: 'amount')}" required="" class="form-control"/></div>
                        </div>

                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="notes">
                                <g:message code="transaction.notes.label" default="Notes" />
                            </label>
                            <g:textArea name="notes" cols="40" rows="5" maxlength="255" value="${transactionInstance?.notes}" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="account">
                            <g:message code="transaction.account.label" default="Account" />
                            <span class="required-indicator">*</span>
                        </label>
                        <g:select id="account" name="account.id" from="${tracking.Account.findAllByActive("Y")}" optionKey="id" required="" value="${transactionInstance?.account?.id}" class="form-control"/>
                        </div>
                    <div class="col-md-12">
                        <g:actionSubmit id="create" action="save" value="${message(code: 'default.button.create.label', default: 'Create')}" class="btn btn-skin pull-left"/>
                    </div>

                </div>
                </g:form>
            </div>

        </div>

    </div>

		</div>
	</section>
	<!-- /Section: contact -->

	<footer>
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-lg-12">

					<p>Copyright &copy; 2014 Ninestars - by <a href="http://bootstraptaste.com">Bootstraptaste</a></p>
				</div>
			</div>
		</div>
	</footer>

    <!-- Core JavaScript Files -->
    <script src="${resource(dir: 'assets/js', file: 'jquery.min.js')}"></script>
    <script src="${resource(dir: 'assets/js', file: 'bootstrap.min.js')}"></script>
    <script src="${resource(dir: 'assets/js', file: 'jquery.easing.min.js')}"></script>
	<script src="${resource(dir: 'assets/js', file: 'classie.js')}"></script>
	<script src="${resource(dir: 'assets/js', file: 'gnmenu.js')}"></script>
	<script src="${resource(dir: 'assets/js', file: 'jquery.scrollTo.js')}"></script>
	<script src="${resource(dir: 'assets/js', file: 'nivo-lightbox.min.js')}"></script>
	<script src="${resource(dir: 'assets/js', file: 'stellar.js')}"></script>
    <!-- Custom Theme JavaScript -->
    <script src="${resource(dir: 'assets/js', file: 'custom.js')}"></script>

</body>

</html>
