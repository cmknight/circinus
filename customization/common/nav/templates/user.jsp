<%-- Copyright IBM Corp. 2011, 2012  All Rights Reserved. --%><%--


   This JSP generates the "User" menu that is displayed when a user clicks or hovers over 
   the link in the Connections header.
                   
=== DO NOT CHANGE ===
--%><%@ page contentType="text/html;charset=UTF-8" %><%--
--%><%@ page import="java.util.Properties" %><%--
--%><%@ page import="com.ibm.ventura.internal.config.helper.api.VenturaConfigurationHelper" %><%--
--%><%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %><%--
--%><%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions" %><%--
--%><%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %><%--
--%><%@ taglib prefix="bidi"   uri="http://www.ibm.com/lconn/tags/bidiutil" %><%--
--%><%@ taglib prefix="lc-ui" uri="http://www.ibm.com/lconn/tags/coreuiutil" %><%--
--%><%@ taglib prefix="lc-cache" uri="http://www.ibm.com/connections/core/cache" %><%--
--%><jsp:useBean id="services" class="com.ibm.lconn.core.web.util.taglib.ServiceEnabledBean" scope="application"/><%--
--%><jsp:useBean id="emailSettings" class="com.ibm.lconn.core.web.util.taglib.EmailSettingsBean" scope="application"/><%--
--%><jsp:useBean id="user" class="com.ibm.lconn.core.acl.model.UserInfo" scope="page"/><%--
--%><jsp:setProperty name="user" property="userId" value="${param.userid}" /><%--
--%><jsp:setProperty name="user" property="displayName" value="${param.username}" /><%--
--%><%
boolean isHomepageSwitcherEnabled = false;

VenturaConfigurationHelper venturaConfig = VenturaConfigurationHelper.Factory.getInstance();
Properties genericProperties = venturaConfig.getGenericProperties();

if(genericProperties != null) {
	isHomepageSwitcherEnabled = Boolean.parseBoolean(genericProperties.getProperty("com.ibm.orient.isHomepageSwitcherEnabled"));
}
request.setAttribute("isHomepageSwitcherEnabled", isHomepageSwitcherEnabled);
%><%--
--%><lc-ui:bundle basename="com.ibm.lconn.core.strings.templates"><%-- 
=== DO NOT CHANGE ===

--%><div id="navMenuUser" aria-label="user options"><table cellspacing="0" class="lotusLayout" role="presentation"><%--
   --%><c:if test="${services.profiles}"><%--
   --%><tr><%--
      --%><td class="lotusNowrap"><%--
         --%><lc-ui:serviceLink serviceName="profiles" var="urlProfiles" /><%--
         --%><a href="${urlProfiles}/html/myProfileView.do"><%--
            --%><fmt:message key="label.menu.profiles.my" /><%--
         --%></a><%--
      --%></td><%--
   --%></tr><%--
   --%></c:if><%--
   
   --%><c:choose><c:when test="${(emailSettings.enabled || emailSettingsEnabled) && services.news}"><%--
   --%><tr><%--
      --%><td class="lotusNowrap" id="headerSettingsLi"><%--
         --%><lc-ui:serviceLink serviceName="news" var="urlSettings" /><%--
         --%><a id="headerSettingsLink" href="<c:out value="${urlSettings}?lastApp=${param.appName}" />"><%--
            --%><fmt:message key="label.header.settings" /><%--
         --%></a><%--
      --%></td><%--
   --%></tr><%--
   --%></c:when><c:when test="${services.oauth}"><%--
   --%><tr><%--
      --%><td class="lotusNowrap" id="headerSettingsLi"><%--
         --%><lc-ui:serviceLink serviceName="oauth" var="urlOAuth" /><%--
         --%><a id="headerSettingsLink" href="<c:out value="${urlOAuth}/apps" />"><%--
            --%><fmt:message key="label.header.settings" /><%--
         --%></a><%--
      --%></td><%--
   --%></tr><%--
   --%></c:when></c:choose><%--
   
   --%><c:if test="${isHomepageSwitcherEnabled && services.orient && services.homepage}"><%--
	   --%><tr><%--
	   		--%><td dojoType="lconn.core.widget.HomeLink" ></td><%--
	   --%></tr><%--
   --%></c:if><%--

   --%><tr><%--
      --%><td class="lotusNowrap" id="logoutContainer"><%--
      --%></td><%--
   --%></tr><%--

--%></table><div class="lotusNavMenuConnector"></div></div><%--

--%></lc-ui:bundle>