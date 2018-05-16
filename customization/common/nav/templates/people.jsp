<%-- Copyright IBM Corp. 2011  All Rights Reserved. --%><%--
                   

   This JSP generates the "Profiles" menu that is displayed when a user clicks or hovers over 
   the link in the Connections header.
                   
=== DO NOT CHANGE ===
--%><%@ page contentType="text/html;charset=UTF-8" %><%--
--%><%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %><%--
--%><%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions" %><%--
--%><%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %><%--
--%><%@ taglib prefix="bidi"   uri="http://www.ibm.com/lconn/tags/bidiutil" %><%--
--%><%@ taglib prefix="lc-ui" uri="http://www.ibm.com/lconn/tags/coreuiutil" %><%--
--%><%@ taglib prefix="lc-cache" uri="http://www.ibm.com/connections/core/cache" %><%--
--%><jsp:useBean id="services" class="com.ibm.lconn.core.web.util.taglib.ServiceEnabledBean" scope="application"/><%--
--%><lc-ui:bundle basename="com.ibm.lconn.core.strings.templates"><%-- 
=== DO NOT CHANGE ===

--%><div role="document"><table class="lotusLayout lotusNavMenuLarge" cellpadding="0" cellspacing="0"><%--

   --%><lc-ui:serviceLink serviceName="profiles" var="urlProfiles" /><%--

   --%><tr><%--
      --%><th scope="row" class="lotusNowrap"><%--
         --%><a href="${urlProfiles}/html/myProfileView.do"><%--
            --%><strong><fmt:message key="label.menu.profiles.my" /></strong><%--
         --%></a><%--
      --%></th><%--
      
      --%><td class="lotusNowrap lotusLastCell"><%--
         --%><a href="<c:out value="${urlProfiles}" />/html/editMyProfileView.do"><%--
            --%><fmt:message key="label.menu.profiles.editmy" /><%--
         --%></a><%--
      --%></td><%--
   --%></tr><%--
   
   --%><tr><%--
      --%><th scope="row" class="lotusNowrap lotusLastCell"><%--
         --%><a href="<c:out value="${urlProfiles}" />/html/networkView.do?widgetId=friends&requireAuth=true"><%--
            --%><strong><fmt:message key="label.menu.profiles.mynetwork" /></strong><%--
         --%></a><%--
      --%></th><%--
   
      --%><c:if test="${services.homepage}"><%--
         --%><lc-ui:serviceLink serviceName="homepage" var="urlHomepage" /><%--
   
         --%><td class="lotusNowrap lotusLastCell"><%--
            --%><a href="<c:out value="${urlHomepage}" />/web/updates/#statusUpdates/all"><%--
               --%><fmt:message key="label.menu.profiles.mystatusupdates" /><%--
            --%></a><%--
         --%></td><%--
      --%></c:if><%--
   --%></tr><%--
   
   --%><tr><%--
      --%><th scope="row" class="lotusNowrap lotusLastCell"><%--
         --%><a href="<c:out value="${urlProfiles}" />/html/searchProfiles.do"><%--
            --%><strong><fmt:message key="label.menu.profiles.directory" /></strong><%--
         --%></a><%--
      --%></th><%--
   --%></tr><%--
   
--%></table></div><%--

--%></lc-ui:bundle>
