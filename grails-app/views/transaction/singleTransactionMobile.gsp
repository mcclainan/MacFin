<%@ page import="tracking.Transaction" %>
<!doctype html>
<html class="no-js" lang="en">
<head>
    <title>Single Transaction</title>
    <meta charset="utf-8">
    <meta name="HandheldFriendly" content="True">
    <meta name="MobileOptimized" content="320">
    <meta name="viewport" content="minimum-scale=1.0, width=device-width, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" href="${resource(dir:'assets/css',file: 'style.css')}">
    <link rel="stylesheet" href="${resource(dir:'assets/fonts',file: 'raphaelicons.css')}">
    <link rel="stylesheet" href="${resource(dir:'assets/css',file: 'main.css')}">
    <link href="http://fonts.googleapis.com/css?family=Oswald:regular" rel="stylesheet" type="text/css">
    <link href='http://fonts.googleapis.com/css?family=Junge' rel='stylesheet' type='text/css'>
    <script src="${resource(dir:'assets/js/libs',file: 'modernizr-2.5.2.min.js')}"></script>
    <g:javascript src="dateSearchCriteria.js" />
    <g:javascript>
			document.getElementById("category.id").focus()

			function populateField(id,value){
				document.getElementById(id).value = value;
			}

			function resetForm(){
				var date = ${new Date().format("dd").toInteger()}
        var month = ${new Date().format("MM").toInteger()}
        var year = ${new Date().format("yyyy").toInteger()}

        populateField("transactionDate_day", date)
        populateField("transactionDate_month",month)
        populateField("transactionDate_year",year)
        populateField("name","")
        populateField("amount","")
        populateField("notes","")
        populateField("category.id",1)
        populateField("account",1)
        populateField("assetLiability","null")
        populateField("id","")

        enableElement("create")
        enableElement("update")
        enableElement("delete")
        document.getElementById("transactionDate_day").focus()
    }


    </g:javascript>
</head>
<body>
<header class="clearfix">
    <div class="container">
        <nav class="clearfix">
            <ul role="navigation">
                <li> <a href="index.html"><span class="icon">S</span>Home</a> </li>
                <!-- <li> <a href="portfolio.html"><span class="icon">Û</span>Portfolio</a> </li>
        <li> <a href="page.html" class="activePage"><span class="icon">E</span>Page</a> </li>
        <li> <a href="blog.html"><span class="icon">E</span>Blog</a> </li>
        <li> <a href="contact.html"><span class="icon">M</span>Contact us</a> </li> -->
            </ul>
        </nav>
    </div>
</header>
<section class="container clearfix">

    <article class="post content">
        <h2>Single Transaction</h2>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${transactionInstance}">
            <ul class="errors" role="alert">
                <g:eachError bean="${transactionInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <g:form url="[resource:transactionInstance, action:'save']" class="c-form">
            <label for="transactionDate"><g:message code="transaction.transactionDate.label" default="Transaction Date" /></label>
            <g:datePicker name="transactionDate" precision="day"  value="${transactionInstance?.transactionDate}" />
            <br/>
            <label for="category">Category</label>
            <g:if test="${mobile}">
                <g:select id="category" name="category.id" from="${category.Category.findAllWhere(active:'Y',displayOnMobile:'Y',[sort:"name"])}" optionKey="id" required="" value="${transactionInstance?.category?.id}" class="category"/>
            </g:if>
            <g:else>
                <g:select id="category" name="category.id" from="${category.Category.findAllByActive("Y",[sort:"name"])}" optionKey="id" required="" value="${transactionInstance?.category?.id}" class="category"/>
            </g:else>
            <label for="name">Name</label>
            <g:textField name="name" required="" value="${transactionInstance?.name}"/>

            <label for="amount">Amount</label>
            <g:field type="number" name="amount" step="any" value="${fieldValue(bean: transactionInstance, field: 'amount')}" required=""/>

            <label for="notes">Notes</label>
            <g:textArea name="notes" cols="40" rows="5" maxlength="255" value="${transactionInstance?.notes}"/>

            <label for="account">Account</label>
            <g:select id="account" name="account.id" from="${tracking.Account.findAllByActive("Y")}" optionKey="id" required="" value="${transactionInstance?.account?.id}" class="many-to-one"/>

            <g:actionSubmit id = "create" action="save" name="create" class="button green" value="${message(code: 'default.button.create.label', default: 'Create')}" disabled="false" />
            <br>
            <input type = "button" name="refreshForm" class="button green" value="Reset Form" onclick = "resetForm()"/>
        </g:form>

    </article>
</section>
<footer role="contentinfo">
    <p> <span class="left">Design by <a target="_blank" href="http://www.shekhardesigner.com/">Shekhar Sharma</a></span> | <g:link uri="/">HOME</g:link></p>
</footer>
<script src="${resource(dir: "assets/js/libs", file: 'jquery-1.7.1.min.js')}"></script>
<script src="${resource(dir: "assets/js", file: 'script.js')}"></script>
</body>
</html>