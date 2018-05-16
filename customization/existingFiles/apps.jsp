<%-- Copyright IBM Corp. 2011, 2014  All Rights Reserved. --%><%--
                   

   This JSP generates the "Apps" menu that is displayed when a user clicks or hovers over 
   the link in the Connections header.  Each of the "other" services has a row in this table.
                   
=== DO NOT CHANGE ===
--%><%@ page contentType="text/html;charset=UTF-8" %><%--
--%><%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %><%--
--%><%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions" %><%--
--%><%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %><%--
--%><%@ taglib prefix="bidi"   uri="http://www.ibm.com/lconn/tags/bidiutil" %><%--
--%><%@ taglib prefix="lc-ui" uri="http://www.ibm.com/lconn/tags/coreuiutil" %><%--
--%><%@ taglib prefix="lc-cache" uri="http://www.ibm.com/connections/core/cache" %><%--
--%><jsp:useBean id="services" class="com.ibm.lconn.core.web.util.taglib.ServiceEnabledBean" scope="application"/><%--
--%><lc-ui:bundle basename="com.ibm.lconn.core.strings.templates"><%

com.ibm.connections.mtconfig.ConfigEngine.useBean(pageContext);

%><%-- 
=== DO NOT CHANGE ===

   The <lc-ui:serviceLink /> tag can be used to generate links to any service defined in
   LotusConnections-config.xml.

--%><div role="document"><table class="lotusLayout lotusNavMenuLarge" cellpadding="0" cellspacing="0"><%-- 
   
   
   Activities
   
   --%><c:if test="${services.activities and not (mtConfig.enabled and mtConfig['activities.standalone.disabled'])}"><%--
      --%><tr><%--
         --%><lc-ui:serviceLink serviceName="activities" var="urlActivities" /><%--
      
         --%><th scope="row" class="lotusNowrap"><%--
            --%><img class="lconnSprite lconnSprite-iconActivitiesBlue16" src="<lc-ui:blankGif />" alt="" role="presentation"><%--
            --%><a href="<c:out value="${urlActivities}" />/service/html/mainpage#dashboard,myactivities"><%--
               --%><strong><fmt:message key="connections.component.name.activities" /></strong><%--
            --%></a><%-- 
         --%></th><%--
         
         --%><td class="lotusNowrap"><%--
            --%><a href="<c:out value="${urlActivities}" />/service/html/mainpage#todolist"><%--
               --%><fmt:message key="label.menu.activities.todo" /><%--
               --%></a><%--
         --%></td><%--
         
         --%><td class="lotusNowrap lotusLastCell"><%--
            --%><a href="<c:out value="${urlActivities}" />/service/html/mainpage#dashboard,highpriority"><%--
               --%><fmt:message key="label.menu.activities.highpriority" /><%--
            --%></a><%--
         --%></td><%--
      --%></tr><%--
   --%></c:if><%--
   
   
   Blogs
   
   --%><c:if test="${services.blogs and not (mtConfig.enabled and mtConfig['blogs.standalone.disabled'])}"><%--
      --%><tr><%--
         --%><lc-ui:serviceLink serviceName="blogs" var="urlBlogs" /><%--
         
         --%><th scope="row" class="lotusNowrap"><%--
            --%><img class="lconnSprite lconnSprite-iconBlogsBlue16" src="<lc-ui:blankGif />" alt="" role="presentation"><%--
            --%><a href="<c:out value="${urlBlogs}" />/"><%--
               --%><strong><fmt:message key="connections.component.name.blogs" /></strong><%--
            --%></a><%--
         --%></th><%--
         
         --%><td class="lotusNowrap"><%--
            --%><a href="<c:out value="${urlBlogs}" />/roller-ui/homepage"><%--
               --%><fmt:message key="label.menu.blogs.latestentries" /><%--
            --%></a><%--
         --%></td><%--
         
         --%><td class="lotusNowrap lotusLastCell"><%--
            --%><a href="<c:out value="${urlBlogs}" />/roller-ui/allblogs"><%--
               --%><fmt:message key="label.menu.blogs.public" /><%--
            --%></a><%--
         --%></td><%--
      --%></tr><%--
   --%></c:if><%--
   
   
   Bookmarks
   
   --%><c:if test="${services.dogear and not (mtConfig.enabled and mtConfig['dogear.standalone.disabled'])}"><%--
      --%><tr><%--
         --%><lc-ui:serviceLink serviceName="dogear" var="urlBookmarks" /><%--
      
         --%><th scope="row" class="lotusNowrap"><%--
            --%><img class="lconnSprite lconnSprite-iconBookmarksBlue16" src="<lc-ui:blankGif />" alt="" role="presentation"><%--
            --%><a href="<c:out value="${urlBookmarks}" />/"><%--
               --%><strong><fmt:message key="connections.component.name.bookmarks" /></strong><%--
            --%></a><%--
         --%></th><%--
         
         --%><td class="lotusNowrap"><%--
            --%><a href="<c:out value="${urlBookmarks}" />/html/popular"><%--
               --%><fmt:message key="label.menu.bookmarks.popular" /><%--
            --%></a><%--
         --%></td><%--
         
         --%><td class="lotusNowrap lotusLastCell"><%--
            --%><a href="<c:out value="${urlBookmarks}" />/html"><%--
               --%><fmt:message key="label.menu.bookmarks.public" /><%--
            --%></a><%--
         --%></td><%--
      --%></tr><%--
   --%></c:if><%--
   
   
   Files
   
   --%><c:if test="${services.files and not (mtConfig.enabled and mtConfig['files.standalone.disabled'])}"><%--
      --%><tr><%--
         --%><lc-ui:serviceLink serviceName="files" var="urlFiles" /><%--
         
         --%><th scope="row" class="lotusNowrap"><%--
            --%><img class="lconnSprite lconnSprite-iconFilesBlue16" src="<lc-ui:blankGif />" alt="" role="presentation"><%--
            --%><a href="<c:out value="${urlFiles}" />/app"><%--
               --%><strong><fmt:message key="connections.component.name.files" /></strong><%--
            --%></a><%--
         --%></th><%--
         
         --%><td class="lotusNowrap"><%--
            --%><a href="<c:out value="${urlFiles}" />/app#/shares?pivot=withme"><%--
               --%><fmt:message key="label.menu.files.sharedwithme" /><%--
            --%></a><%--
         --%></td><%--
         
         --%><td class="lotusNowrap lotusLastCell"><%--
            --%><a href="<c:out value="${urlFiles}" />/app#/folders/pinned"><%--
               --%><fmt:message key="label.menu.files.favoritefolders" /><%--
            --%></a><%--
         --%></td><%--
      --%></tr><%--
   --%></c:if><%--
   
   
   Forums
   
   --%><c:if test="${services.forums and not (mtConfig.enabled and mtConfig['forums.standalone.disabled'])}"><%--
      --%><tr><%--
         --%><lc-ui:serviceLink serviceName="forums" var="urlForums" /><%--

         --%><th scope="row" class="lotusNowrap"><%--
            --%><img class="lconnSprite lconnSprite-iconForumsBlue16" src="<lc-ui:blankGif />" alt="" role="presentation"><%--
            --%><a href="<c:out value="${urlForums}" />/"><%--
               --%><strong><fmt:message key="connections.component.name.forums" /></strong><%--
            --%></a><%--
         --%></th><%--
      
         --%><td class="lotusNowrap"><%--
            --%><a href="<c:out value="${urlForums}" />/html/my?view=owner"><%--
               --%><fmt:message key="label.menu.forums.owner" /><%--
            --%></a><%--
         --%></td><%--
      
         --%><td class="lotusNowrap lotusLastCell"><%--
            --%><a href="<c:out value="${urlForums}" />/html/public"><%--
               --%><fmt:message key="label.menu.forums.public" /><%--
            --%></a><%--
         --%></td><%--
      --%></tr><%--
   --%></c:if><%--
   
   
   Wikis
   
   --%><c:if test="${services.wikis and not (mtConfig.enabled and mtConfig['wikis.standalone.disabled'])}"><%--
      --%><tr><%--
         --%><lc-ui:serviceLink serviceName="wikis" var="urlWikis" /><%--
      
         --%><th scope="row" class="lotusNowrap"><%--
            --%><img class="lconnSprite lconnSprite-iconWikisBlue16" src="<lc-ui:blankGif />" alt="" role="presentation"><%--
            --%><a href="<c:out value="${urlWikis}" />/"><%--
               --%><strong><fmt:message key="connections.component.name.wikis" /></strong><%--
            --%></a><%--
         --%></th><%--
      
         --%><td class="lotusNowrap"><%--
            --%><a href="<c:out value="${urlWikis}" />/home/mywikis?role=owner"><%--
               --%><fmt:message key="label.menu.wikis.owner" /><%--
            --%></a><%--
         --%></td><%--
         
         --%><td class="lotusNowrap lotusLastCell"><%--
            --%><a href="<c:out value="${urlWikis}" />/home/public"><%--
               --%><fmt:message key="label.menu.wikis.public" /><%--
            --%></a><%--
         --%></td><%--
      --%></tr><%--
   --%></c:if><%--
   
--%></table></div><%--

--%></lc-ui:bundle>