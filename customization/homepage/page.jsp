<%--
 ***************************************************************** 
                                                                   
 IBM Confidential                                                  
                                                                   
 OCO Source Materials                                              
                                                                   
 Copyright IBM Corp. 2011, 2013                                    
                                                                   
 The source code for this program is not published or otherwise    
 divested of its trade secrets, irrespective of what has been      
 deposited with the U.S. Copyright Office.                         
                                                                   
 ***************************************************************** 

--%><%--
--%><%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ibm.lconn.core.web.layout.LocationNode,
							java.util.List,
							java.util.Set,
							java.util.HashSet,
							java.util.Map,
							com.ibm.lconn.core.web.layout.AbstractPageDefinition,
							com.ibm.lconn.core.web.layout.PageSerializer,
							org.apache.commons.lang.StringEscapeUtils
							"%><%--
--%><%@ page contentType="text/html;charset=UTF-8"%><%--
--%><%@ taglib prefix="c"		  uri="http://java.sun.com/jsp/jstl/core" %><%--
--%><%@ taglib prefix="fn"		uri="http://java.sun.com/jsp/jstl/functions" %><%--
--%><%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt" %><%--
--%><%@ taglib prefix="lc-ui"	 uri="http://www.ibm.com/lconn/tags/coreuiutil" %><%--
--%><%@ taglib prefix="lc-cache" uri="http://www.ibm.com/connections/core/cache" %><%--
--%><%@ taglib prefix="lc-nav"	uri="http://www.ibm.com/lconn/tags/corenav"%><%-- 

--%><c:set scope="request" var="oneuiVersion" value="3" /><%--

--%><jsp:useBean id="services" class="com.ibm.lconn.core.web.util.taglib.ServiceEnabledBean" scope="application"/><%--
--%><% AbstractPageDefinition definition = (AbstractPageDefinition)request.getAttribute("page"); %><%-- FIXME: replace all attributes with object
--%><% PageSerializer.setThreadLocale(request.getLocale()); %><%-- FIXME: Move to PageHelperTag
--%><% List<LocationNode> location = definition.getLocation(); %><%--


TODO
authJS
businesscard setup
search scopes

--%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html dir="${dir}" lang="${lang}">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title><c:out value="${title}" /></title>

	<lc-ui:stylesheets theme="${theme}" />
	<lc-ui:dojo include="${javascriptModuleInclude}" />

<script>
var page = com.ibm.lconn.layout.page;
var data = page.data = {<%
    
	boolean firstData = true;
	for (Map.Entry<String, Object> data : definition.getData().entrySet())
	{
		String dynamicDataRetriever = definition.getDynamicDataRetriever(data.getKey());
	  	if (data.getValue() == null || dynamicDataRetriever != null)
			continue;
	
	  	if (!firstData) {
			%>,<%
		}
		firstData = false;
		out.println();
		 	  	  
%>	<%= StringEscapeUtils.escapeHtml(data.getKey()) %>:<% PageSerializer.DATA.writeValue(out, data.getValue());
	}

%>
};
<%
	for (Map.Entry<String, Object> data : definition.getData().entrySet())
	{
 		String dynamicDataRetriever = definition.getDynamicDataRetriever(data.getKey());
		if (dynamicDataRetriever == null)
			continue;		 	  
%>data.<%= StringEscapeUtils.escapeHtml(data.getKey()) %>=<%= dynamicDataRetriever %>(<% PageSerializer.DATA.writeValue(out, data.getValue()); %>);
<%
	}

%></script>

	<link rel="shortcut icon" href="<lc-cache:uri template="${favicon}" />" type="image/x-icon">
	<c:if test="${not empty introspectionHref}"><link rel="service" type="application/atomsvc+xml" title="Atom Publishing Protocol Service Document" href="${introspectionHref}"></c:if>
</head>
<body id="body" class="lotusui30 lotusui30_body lotusui30_fonts <lc-ui:languageClassname /> <c:if test="${showLoading}">lconnHideContent</c:if> <c:if test="${!showLoading}">lconnHideLoading</c:if>">

	<div id="lotusFrame" class="lotusFrame lotusui30_layout">
		<div id="lotusBanner" class="lotusBanner" role="banner">
			<jsp:include page="header.jsp" />
		</div>
		
		<div class="lotusTitleBar2" role="header">
			<div class="lotusRightCorner"><div class="lotusInner">
				<div class="lotusTitleBarContent">&nbsp;</div>
				<c:if test="${page.search.visible}">
				<form class="lotusGlobalSearch" action=":;" method="post" role="search">
				<input type="text" id="globalSearch" class="lotusSearch" <c:if test="${page.search.primary}">style="width: 40em;"</c:if>>
				</form>
				<c:if test="${fn:length(page.search.scopes) gt 1 or not empty page.search.suggestionWidget}">
				<style>				
					ul.lotusSearchMenu .lotusSearchScope {border-bottom: 1px solid #aaa; padding: 5px; padding-top: 0;}
					ul.lotusSearchMenu .lotusSearchScope div {margin-left: 10px;}
					ul.lotusSearchMenu h4 {font-size: 1.0em; font-weight: bold; padding: 2px 4px; margin: 0;}
					ul.lotusSearchMenu {width: 40em;}
					ul.lotusSearchMenu .dijitMenuItem {text-overflow: ellipsis; word-wrap: normal;}
					ul.lotusSearchMenu .dijitMenuItemText {margin-left: 5px; font-style: italic;}
					ul.lotusSearchMenu .dijitMenuItemSelected {background-color:#fefebb;color:#000}
					.lotusui30 input.lotusLoading {background-position: right center; height: auto; width: auto;}
				</style>					
				<script>page.search.init(function() {return {<c:if test="${not empty page.search.suggestionWidget}">suggest: ${page.search.suggestionWidget}, </c:if>scopes:<% PageSerializer.DATA.writeValue(out, definition.getSearch().getScopes()); %>};},dojo.byId("globalSearch"));</script>
				</c:if>
				</c:if>
			</div></div>
		</div>
		
		<div class="lotusPlaceBar">
			<div id="locationBarDiv" class="lotusLeft" style="padding: 0.5em 10px 0.5em 20px">&nbsp;</div>
			<div class="lotusBtnContainer">
				<span id="globalActionsDiv"></span>
				<span id="pageActionsDiv"></span>
			</div>
		</div>		

		<noscript>
			<style type="text/css">
				.lotusFrame * { display: none; }
				.lotusFrame .lotusErrorBox { display: block; }
			</style>
			<div class="lotusErrorBox lotusError">
				<div class="lotusErrorContent">
					<img class="iconsMessages48 iconsMessages48-msgError48" src="<lc-ui:blankGif />" alt="">
					<div class="lotusErrorForm">
						<h1>Turn on JavaScript</h1>
						<p>JavaScript has been disabled in your web browser.  This application requires JavaScript in order to function.  Once you have turned it on, please refresh the page.</p>
						<p>Refresh the page to continue.</p>
						</div>
				</div>
			</div>
		</noscript>
		
		<div id="lconnApplicationLoading" class="lconnApplicationLoading">Loading...</div>

		<div id="lotusMain" class="lotusMain">
			<div id="lotusColLeft" class="lotusColLeft" <c:if test="${!showLotusColLeft}" >style="display: none;"</c:if>>
				  <% 
				  String containerType = null;
				  for (LocationNode node : location)
					 if (node.hasContainerType()) 
					 {
						containerType = node.getContainerType();
						Map<String,String> containerTypes = (Map<String,String>)request.getAttribute("pageContainerTypes");
						String containerPage = containerTypes.get(containerType);
						if (containerPage != null)
						  pageContext.include(containerPage);
						else {
						  %><!-- Container type <%= StringEscapeUtils.escapeHtml(containerType) %> not registered --><%
						}
						break;
					 }
				  %>
				
				<div class="lotusMenu" id="lotusMenu" style="display:none;" role="navigation" aria-label="Main navigation"><div class="lotusBottomCorner"><div class="lotusInner">
					<div id="lotusMenuTree"></div>
					</div></div></div>

<script type="text/javascript">
<%
	Set<String> when = new HashSet<String>();
	for (LocationNode node : location)
		when.addAll(node.getWhen().keySet());
		  
	%>page.location = new com.ibm.social.layout.widget.LocationBar({<% 
			
	if (when.isEmpty())
	{
		%>data:<% PageSerializer.LOCATION.writeValue(out, location);
	}
	%>}, dojo.byId("locationBarDiv"));<%
			
	if (!when.isEmpty())
	{

%>
page.when(<% PageSerializer.LOCATION.writeValue(out, when); %>, function() {
	var location = page.location;
	location.update([<%
	                 
		boolean firstNode = true;
		for (LocationNode node : location)
		{
			if (!firstNode)
			{
				%>,<%
			}
			firstNode = false;
			
			int nesting = 0;
			for (String condition : node.getWhen().values())
			{
			  nesting++;
			  %><%= condition %>(<%
			}
			PageSerializer.DATA.writeValue(out, node);
			java.lang.StringBuffer sbf = new java.lang.StringBuffer();
			%><%= StringUtils.repeat(")", nesting) %><%
		}
	%>]);
});<% 

	}
%>
var actions = page.actions;
var defaultContext = {context: dojo.delegate(data,{})}; 
actions.page = new com.ibm.social.layout.widget.ActionBar(defaultContext, dojo.byId("pageActionsDiv"));
actions.global = new com.ibm.social.layout.widget.ActionBar(defaultContext, dojo.byId("globalActionsDiv"));
<%

	Set<String> whenActions = definition.getWhen().get("!actions");
	boolean hasWhenActions = (whenActions != null && !whenActions.isEmpty());
	if (hasWhenActions) {
	  
%>page.when(<% PageSerializer.DATA.writeValue(out, definition.getWhen().get("!actions")); %>, function() {
<%
  
	}

%>actions.page.addAll([
${pageActionsJS}]); 
actions.global.addAll([
${globalActionsJS}]);
<% 
	  
	if (hasWhenActions) {
%>});<%
	}

	if (!definition.getNavigationItems().isEmpty()) { %>				
	page.navigation.init({
		 model: new dijit.tree.ForestStoreModel({
			 store: new dojo.data.ItemFileReadStore({data: {label: "label", identifier: "id", items: <% PageSerializer.NAVIGATION.writeValue(out, definition.getNavigationItems()); %>}})
		 })
	 });
<%  } %>
</script>

				  <c:if test="${lotusColLeftJSP != null}"><jsp:include page="${lotusColLeftJSP}" /></c:if>
			</div>
			<div id="lotusColRight" class="lotusColRight" <c:if test="${!showLotusColRight}" >style="display: none;"</c:if>>
				 <c:if test="${lotusColRightJSP != null}"><jsp:include page="${lotusColRightJSP}" /></c:if>
			</div>
			<div id="lotusContent" class="lotusContent">
				 <c:if test="${lotusContentJSP != null}"><jsp:include page="${lotusContentJSP}" /></c:if>
			</div>
		</div>

		<div id="lotusFooter" class="lotusFooter" role="contentinfo">
			<jsp:include page="footer.jsp" />
		</div>
	</div>

	<%-- 
	The following markup includes images and CSS that includes images for IE6.
	If the images are not referenced explicitly in markup, they get requested repeatedly in the nocache scenario.
	--%>
	<!--[if IE 6]>
	<div class="lotusHidden">
		<div class="lotusButton"><a href="#" title="">&nbsp;</a></div>
		<img class="lconnSprite lconnSprite-iconFiles16" src="<lc-ui:blankGif />" alt="">
		<img class="lconn-ftype16" src="<lc-ui:blankGif />" alt="">
	</div>
	<![endif]-->

</body>
</html>
