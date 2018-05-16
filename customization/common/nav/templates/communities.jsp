<%-- Copyright IBM Corp. 2011, 2016  All Rights Reserved. --%><%-- 


   This JSP generates the "Communities" menu that is displayed when a user clicks or hovers over 
   the link in the Connections header.  If the request contains a parameter "authenticated" 
   the communities the current user is following will be shown.  Otherwise, only the first 
   two links are shown.

=== DO NOT CHANGE ===
--%><%@ page contentType="text/html;charset=UTF-8" import="com.ibm.lconn.core.web.util.config.GlobalConfiguration,
    com.ibm.lconn.core.web.mt.TenantLookupFilter" %><%--
--%><%@ page import="com.ibm.lconn.core.gatekeeper.LCSupportedFeature" %><%--
--%><%@ page import="com.ibm.lconn.core.gatekeeper.LCGatekeeper" %><%--
--%><%@ page import="com.ibm.lconn.core.web.util.config.OrganizationUtil" %><%--
--%><%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %><%--
--%><%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions" %><%--
--%><%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %><%--
--%><%@ taglib prefix="bidi"   uri="http://www.ibm.com/lconn/tags/bidiutil" %><%--
--%><%@ taglib prefix="lc-ui" uri="http://www.ibm.com/lconn/tags/coreuiutil" %><%--
--%><%@ taglib prefix="lc-cache" uri="http://www.ibm.com/connections/core/cache" %><%--
--%><lc-ui:bundle basename="com.ibm.lconn.core.strings.templates"><%--
--%><lc-ui:serviceLink serviceName="communities" var="urlCommunities" /><%--
--%><c:if test="${param.authenticated == 'true'}" var="isAuthenticated" scope="page" /><%

boolean canFollow = GlobalConfiguration.usersCanFollowContent();

pageContext.setAttribute("canFollow", Boolean.valueOf(canFollow));

com.ibm.connections.mtconfig.ConfigEngine.useBean(pageContext);

pageContext.setAttribute("isRbLEnabled", LCGatekeeper.isEnabled(LCSupportedFeature.COMMUNITIES_LIST_RESTRICTED, request));
String myOrgCommunities = com.ibm.lconn.core.web.util.config.OrganizationUtil.getMyOrganizationCommunitiesForCurrentUser(request);
if (myOrgCommunities != null)
	pageContext.setAttribute("myOrgCommunities", myOrgCommunities);

%><%--
=== DO NOT CHANGE ===

--%><c:set var="canFollow" value="${canFollow and (not mtConfig.enabled or mtConfig['users.can.follow.content'])}" /><%--
--%><div role="document"><table dojoType="dijit._Widget" class="lotusLayout" cellpadding="0" cellspacing="0" role="presentation"><%-- 
    
   When the user is authenticated, we will call the Community REST API to retrieve the seven most
   recently updated communities the user is following.  The menu will wait a fraction of a second
   after opening before retrieving the list of communities, so that moving the mouse cursor over
   the header menus rapidly will not begin the request.
      
--%><c:if test="${isAuthenticated}">

   <script type="dojo/method" event="postCreate">
      this.parent = dijit.getEnclosingWidget(this.domNode.parentNode);
      this.connect(this.parent, "onOpen", "onParentOpened");
      dojo.query("[dojoAttachPoint]", this.domNode).forEach(function(n) {this[dojo.attr(n, "dojoAttachPoint")] = n;}, this);
      this.delayLoad();
   </script>   
   <script type="dojo/method" event="onParentOpened">
      this.delayLoad();
   </script>   
   <script type="dojo/method" event="expire">
      this.loaded = false;
   </script>   
   <script type="dojo/method" event="delayLoad">
   <c:if test="${canFollow}">
	  setTimeout(dojo.hitch(this, "load"), 325);
   </script>   
   <script type="dojo/method" event="load">
	  // Reset size of container div so border is properly calculated.
      var container = dojo.byId("lconnheadermenu-communities");
	  if(container != null) {
	  	container.style.width = "";
	  	container.style.height = "";
	  }

      if (!this.parent._launcher._opened)
         return;
      if (this.isLoading || this.loaded)
         return;
      this.isLoading = true;
      var url = "${urlCommunities}/service/atom/forms/communities/my?sortField=lastmod&sortOrder=descending&filterType=following&ps=7";
      url = com.ibm.oneui.util.proxy(url);
      var dfd = dojo.xhrGet({url: url, handleAs: "xml", auth: {secured: false}});
      dfd.addCallback(this, "loadCommunities").addErrback(this, "loadError");
   </script>   
   <script type="dojo/method" event="loadCommunities" args="doc">
      this.loaded = true; this.isLoading = false;
      setTimeout(dojo.hitch(this, "expire"), 10*60*1000);

      var feed = doc.documentElement;
      var MAX_NAME_LENGTH = 50;
      var entries = feed.getElementsByTagName("entry");

      var t = this.template;
      var tbody = t.parentNode;
      while (t.nextSibling)
         tbody.removeChild(t.nextSibling);
      this.empty.style.display = this.info.style.display = this.loading.style.display = this.error.style.display = "none";

      if (entries.length > 0) {
         var items = [];
         for (var i=0,c=Math.min(entries.length,7); i<c; i++) {
            var entry = entries[i];
            var title = entry.getElementsByTagName("title")[0];
            title = title.text || title.textContent;
            items.push({
               title: title,
               link: dojo.query("link[rel='alternate'][type='text/html']", entry)[0].getAttribute("href")
            });
         }
         items.sort(function(a,b) {if (a.title > b.title) return 1; if (a.title < b.title) return -1; return 0;});
         this.info.style.display = "";
         for (var i=0,c=Math.min(items.length,7); i<c; i++) {
            var item = items[i];
            var title = item.title;
            var shortTitle = title.length > MAX_NAME_LENGTH ? (dojo.trim(title.substring(0,MAX_NAME_LENGTH)) + "...") : title;
            var link = item.link;
            var tr = t.cloneNode(true); tr.style.display = ""; dojo.attr(tr, "dojoAttachPoint", null);
            var td = tr.firstChild;
            var a = td.appendChild(document.createElement("a")); 
            a.className = "lotusCommunity"; 
            a.href = link;
            a.setAttribute("aria-describedby","recentCommunities");
            a.dir = lconn.core.globalization.bidiUtil.getTextDirection(shortTitle);
            if (title != shortTitle)
               a.title = lconn.core.globalization.bidiUtil.enforceTextDirection(title);
            a.appendChild(document.createTextNode(shortTitle));
            tbody.appendChild(tr);
         }
      }
      else
         this.empty.style.display = "";

	  // Reset size of container div so border is properly calculated.
      var container = dojo.byId("lconnheadermenu-communities");
	  if(container != null) {
	  	container.style.width = "";
	  	container.style.height = "";
	  }

      console.log("load done");
   </script>
   <script type="dojo/method" event="loadError" args="error">
      this.isLoading = false;
      var t = this.template;
      var status = error.status;

      while (t.nextSibling)
         t.parentNode.removeChild(t.nextSibling);
      this.loading.style.display = this.info.style.display = this.empty.style.display = "none";       

      if(status == "403"|| status == "302" || status == "0"){
         this.errorForbidden.style.display = "";
         this.errorForbidden.title = error ? (error.message || error.status || error) : null;
      }else{
         this.error.style.display = "";
         this.error.title = error ? (error.message || error.status || error) : null;
      }
	
	  // Reset size of container div so border is properly calculated.
      var container = dojo.byId("lconnheadermenu-communities");
	  if(container != null) {
	  	container.style.width = "";
	  	container.style.height = "";
	  }

   </c:if>
   </script>   
   </c:if><%-- 


   These are the normal menu items displayed for all users.

--%><tbody><%--
   --%><tr><%--
      --%><td class="lotusNowrap lotusLastCell"><%--
         --%><a class="lotusBold" href="<c:out value="${urlCommunities}" />/service/html/ownedcommunities"><%--
            --%><fmt:message key="label.menu.communities.owned" /><%--
         --%></a><%--
      --%></td><%--
   --%></tr><%--
   
   --%><tr><%--
      --%><td class="lotusNowrap lotusLastCell"><%--
         --%><a class="lotusBold" href="${urlCommunities}/service/html/mycommunities"><%--
            --%><fmt:message key="label.menu.communities.member" /><%--
         --%></a><%--
      --%></td><%--
   --%></tr><%--
   
   --%><c:if test="${canFollow}"><tr><%--
   --%><td class="lotusNowrap lotusLastCell"><%--
         --%><a class="lotusBold" href="<c:out value="${urlCommunities}" />/service/html/mycommunities?filterType=following"><%--
            --%><fmt:message key="label.menu.communities.following" /><%--
      --%></a><%--
   --%></td><%--
   --%></tr></c:if><%-- 

   --%><tr><%--
   --%><td class="lotusNowrap lotusLastCell"><%--
      --%><a class="lotusBold" href="<c:out value="${urlCommunities}" />/service/html/communityinvites"><%--
         --%><fmt:message key="label.menu.communities.invited" /><%--
      --%></a><%--
   --%></td><%--
--%></tr><%--

   --%><tr class="<c:if test="${isAuthenticated}">lotusMenuSeparator</c:if>"><%--
      --%><td class="lotusNowrap lotusLastCell"><%--
         --%><a class="lotusBold" href="<c:out value="${urlCommunities}" />/service/html/allcommunities"><%--
            --%><c:choose><%--
               --%><c:when test="${(mtConfig.enabled or isRbLEnabled) and not empty myOrgCommunities}"><%--
                  --%>${myOrgCommunities}<%--
               --%></c:when><%--
               --%><c:otherwise><%--
                  --%><fmt:message key="label.menu.communities.public" /><%--
               --%></c:otherwise><%--
            --%></c:choose><%--
         --%></a><%--
      --%></td><%--
   --%></tr><%--
   
   
   These menu items are only visible to authenticated users who can follow communities.
    
   --%><c:if test="${isAuthenticated and canFollow}"><%--
   
      --%></tbody><tbody><tr dojoAttachPoint="loading"><%--
         --%><td class="lotusLastCell"><%--
            --%><span><%--
               --%><img src="<lc-ui:blankGif />" class="lotusLoading" alt="" role="presentation"><%-- 
               --%> <fmt:message key="label.menu.loading" /><%--
            --%></span><%--
         --%></td><%--
      --%></tr><%--
      
      --%><tr dojoAttachPoint="info" style="display: none;"><%--
         --%><td class="lotusLastCell"><%--
            --%><span class="lotusBold" id="recentCommunities"><%--
               --%><fmt:message key="label.menu.communities.recent" /><%--
            --%></span><%--
         --%></td><%--
      --%></tr><%--
      
      --%><tr dojoAttachPoint="error" style="display: none;"><%--
         --%><td class="lotusLastCell"><%--
            --%><span><%--
               --%><fmt:message key="label.menu.communities.error" /><%--
            --%></span><%--
         --%></td><%--
      --%></tr><%--
      
       --%><tr dojoAttachPoint="errorForbidden" style="display: none;"><%--
         --%><td class="lotusLastCell"><%--
            --%><span><%--
               --%><fmt:message key="error.invalidSession.message" /><%--
            --%></span><%--
         --%></td><%--
      --%></tr><%--
      
      --%><tr dojoAttachPoint="empty" style="display: none;"><%--
         --%><td class="lotusLastCell"><%--
            --%><span><%--
               --%><fmt:message key="label.menu.communities.empty" /><%--
            --%></span><%--
         --%></td><%--
      --%></tr><%--
      
      --%><tr dojoAttachPoint="template" style="display: none;"><%--
         --%><td class="lotusLastCell"></td><%--
      --%></tr><%--
      
   --%></c:if><%--
   
   --%></tbody><%--
--%></table></div><%--

--%></lc-ui:bundle>