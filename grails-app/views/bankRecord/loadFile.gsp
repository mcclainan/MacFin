<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="tracking.BankRecord"%>
<%@ page import="tracking.Account"%>
<!doctype html>
	<html>
	<head>
	<meta name="layout" content="tracking">
	<g:set var="entityName"
		value="${message(code: 'bankRecord.label', default: 'BankRecord')}" />
	<title><g:message code="load.file.title"/></title>
	</head>
	<body>
		<div id="primaryContentContainer">
			<div id="primaryContent">
				<h1>Upload Bank Records</h1>
				<g:if test="${flash.message}">
					<div class="message" role="status">
						${flash.message}
					</div>
				</g:if>
				<g:hasErrors bean="${bankRecordInstance}">
					<ul class="errors" role="alert">
						<g:eachError bean="${bankRecordInstance}" var="error">
							<li
								<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
									error="${error}" /></li>
						</g:eachError>
					</ul>
				</g:hasErrors>
				<g:if test="${flash.errors}">
					<ul class="errors" role="alert">
						<g:each in="${flash.errors}" var="error">
							<li>
							 	${error.value}
							</li>
						</g:each>
					</ul>
				</g:if>
				<g:uploadForm action="upload">
					<fieldset class="form">
						<table style="width: 50%">
							<tr>
								<td><g:message code="load.file.file.label" /></td>
								<td><input name="file" type="file"></td>
							</tr>
							<tr>
								<td><g:message code="load.file.account.label" /></td>
								<td><g:select id="account" name="account.id"
										from="${Account.findAllByBankNotNull().list()}" optionKey="id"
										required="" /></td>
							</tr>
						</table>
					</fieldset>
					<fieldset class="buttons">
						<g:submitButton name="upload" value="Upload" />
					</fieldset>
				</g:uploadForm>
			</div>
		</div>
	</body>
</html>