
<%@ page import="category.Category" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="recMaint">
		<g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-category" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-category" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'category.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="priority" title="${message(code: 'category.priority.label', default: 'Priority')}" />
					
						<g:sortableColumn property="cash" title="${message(code: 'category.cash.label', default: 'Cash')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'category.type.label', default: 'Type')}" />
					
						<g:sortableColumn property="active" title="${message(code: 'category.active.label', default: 'Active')}" />
					
						<g:sortableColumn property="displayOnMobile" title="${message(code: 'category.displayOnMobile.label', default: 'Display On Mobile')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${categoryInstanceList}" status="i" var="categoryInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${categoryInstance.id}">${fieldValue(bean: categoryInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: categoryInstance, field: "priority")}</td>
					
						<td>${fieldValue(bean: categoryInstance, field: "cash")}</td>
					
						<td>${fieldValue(bean: categoryInstance, field: "type")}</td>
					
						<td>${fieldValue(bean: categoryInstance, field: "active")}</td>
					
						<td>${fieldValue(bean: categoryInstance, field: "displayOnMobile")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${categoryInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
