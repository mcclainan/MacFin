<!DOCTYPE html>
<%@ page import="tracking.Account" %>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.png')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
		<g:layoutHead/>
		<g:javascript library="application"/>		
				
		<r:layoutResources />
		<style type="text/css">
			#maccontent{
				margin: 1em 14.7em 0 15em;
			}
			
		#dialogBox {
		    background: none repeat scroll 0 0 #EFEFEF;
		    border-color: #006192;
		    border-style: outset;
		    border-width: 0.5em;
		    height: 20em;
		    margin: 6em 1em 1em 24em;
		    position: fixed;
		    visibility: hidden;
		    width: 40em;
		    padding:1em;
		    top:10em;
		    z-index: 1;
		}
		#dialogBoxHead{
			height: 11%;
		}
		#dialogBoxBody{
		    overflow:scroll;
			height: 77%;
		}
		#dialogBoxFooter{
			height: 11%;
	text-align: center;
}
		</style>
		<script type="text/javascript">
			function toggleDialogBoxVisibility(on,refresh){
				if(on=="on"){
					document.getElementById("dialogBox").style.visibility = "visible"
				}else{
					document.getElementById("dialogBox").style.visibility = "hidden"
				}
				if(refresh=='true'){
					window.location.reload()
				}	
			}
		</script>
	</head>
	<body>
		<div id="dialogBox"></div>
		<div id="grailsLogo" role="banner"><a href="${createLink(uri: '/')}">
			<img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Grails" style="height: 5em;"/></a>
			<div class="menu">
				<ul>
					<li class="first"><a class="home"
						href="${createLink(uri: '/')}">Home</a></li>
					<li><g:link controller="transaction">Tracking</g:link></li>
					<li><g:link controller="budgetItem" action="view">Planning</g:link></li>
					<li><g:link controller="report">Reports</g:link></li>
					<li><g:link controller="category">Records Maintenance</g:link></li>
				</ul>
			</div>
		</div>
		<div id="sideBarLeft">
			<h2 style="margin-top: 0em">Bank Account(s)</h2>
			<ul>
				<g:each in="${Account.findAllByActiveAndType('Y','bank')}" var="accountInstance">
					<li>
						${accountInstance.name} <br/><g:formatNumber
							number="${accountInstance.balance}" type="currency"
							currencyCode="USD" />
					</li>
				</g:each>
			</ul>
			<h2 style="margin-top: 0em">School Account(s)</h2>
			<ul>
				<g:each in="${Account.findAllByActiveAndType('Y','school')}" var="accountInstance">
					<li>
						${accountInstance.name} <br/><g:formatNumber
							number="${accountInstance.balance}" type="currency"
							currencyCode="USD" />
					</li>
				</g:each>
			</ul>
			<h2 style="margin-top: 0em">Brokerage Account(s)</h2>
			<ul>
				<g:each in="${Account.findAllByActiveAndType('Y','brokerage')}" var="accountInstance">
					<li>
						${accountInstance.name} <br/><g:formatNumber
							number="${accountInstance.balance}" type="currency"
							currencyCode="USD" />
					</li>
				</g:each>
			</ul>
		</div>
		<g:layoutBody/>
		<div class="footer" role="contentinfo">Version <g:meta name="app.version"/></div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
		<r:layoutResources />
	</body>
</html>

