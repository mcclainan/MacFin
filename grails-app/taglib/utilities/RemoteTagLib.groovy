package utilities

class RemoteTagLib {
    static defaultEncodeAs = 'text'
	static namespace = "Remote"
    static encodeAsForTags = [tagName: 'raw']
	
	/**
	 * Creates a link that triggers an Ajax call formatted as a link
	 * @attr action REQUIRED the action to be called
	 * @attr updateDiv REQUIRED the div tag that will be updated
	 * @attr updateDiv OPTIONAL id field for the request
	 */
	def link = {attrs,body ->
		def controller = attrs.controller?:controllerName
		def action = attrs.action
		def updateDiv = attrs.updateDiv
		def id = attrs.id
		def output = "<a href=\"/${grails.util.Metadata.current.getApplicationName()}/${controller}/${action}/${id}\" onclick = \"new Ajax.Updater('${updateDiv}','/${grails.util.Metadata.current.getApplicationName()}/${controller}/${action}/${id}',{asynchronous:true,evalScripts:true});return false;\" action=\"${action}\"> ${body()}</a>"
		out << output
	}
	
	/**
	 * Creates a link that triggers an Ajax call formatted as a link
	 * @attr action REQUIRED the action to be called
	 * @attr updateDiv REQUIRED the div tag that will be updated
	 * @attr id REQUIRED 
	 */
	def function = {attrs->
		def controller = attrs.controller?:controllerName
		def action = attrs.action
		def updateDiv = attrs.updateDiv
		def id = attrs.id
		
		out << "new Ajax.Updater(${updateDiv},'/${grails.util.Metadata.current.getApplicationName()}/${controller}/${action}/${id}',{asynchronous:true,evalScripts:true});"
	}
	
}
