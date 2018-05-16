<%-- Copyright IBM Corp. 2011, 2014  All Rights Reserved. --%><%--


   This login page is displayed when a user is not authenticated.  The login page will send the user to the page
   they were previously trying to access if they authenticate successfully, or return them to the login page with
   the ${loginError} true if an error occurs.

=== DO NOT CHANGE ===
--%><%@ page contentType="text/html;charset=UTF-8" %><%--
--%><%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %><%--
--%><%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions" %><%--
--%><%@ taglib prefix="fmt"    uri="http://java.sun.com/jsp/jstl/fmt" %><%--
--%><%@ taglib prefix="bidi"   uri="http://www.ibm.com/lconn/tags/bidiutil" %><%--
--%><%@ taglib prefix="lc-ui" uri="http://www.ibm.com/lconn/tags/coreuiutil" %><%--
--%><%@ taglib prefix="lc-cache" uri="http://www.ibm.com/connections/core/cache" %><%--
--%><%@ page import="
        java.net.URL,
        java.net.URLDecoder,
        java.util.Properties,
        org.apache.commons.lang.StringEscapeUtils,
        com.ibm.lconn.core.web.util.ServiceNameHelper,
        com.ibm.ventura.internal.config.helper.api.VenturaConfigurationHelper,
        com.ibm.ventura.internal.config.helper.api.VenturaConfigurationHelper.ComponentEntry" %><%--
--%><% response.addHeader("X-LConn-Login", "true"); %><%--
--%><lc-ui:serviceLink serviceName="help" var="urlHelp"/><%--
--%><lc-ui:bundle basename="com.ibm.lconn.core.strings.templates"><%--
=== DO NOT CHANGE ===

--%><%
	String serverSideRedirectURL = null;
	VenturaConfigurationHelper venturaConfig = VenturaConfigurationHelper.Factory.getInstance();
	Properties genericProperties = venturaConfig.getGenericProperites();
	boolean isLoginRedirectDisabled = false;
	if(genericProperties != null) {
		isLoginRedirectDisabled = "false".equals(genericProperties.getProperty("login.redirect.on.authenticated.access"));
	}
	if (!isLoginRedirectDisabled && request.getUserPrincipal() != null && request.getParameter("forceLogin") == null) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("WASReqURL".equals(cookie.getName())) {
					// remove the WASReqURL cookie since it's no longer needed and could confuse
					// other login pages later on
					cookie.setMaxAge(0);
					response.addCookie(cookie);
					// get the redirect from the cookie
					serverSideRedirectURL = java.net.URLDecoder.decode(cookie.getValue(), "UTF-8");
					break;
				}
			}
		}
		// sometimes we put the URL to redirect to in a URL param, such as for files download URLs
		if (serverSideRedirectURL == null && request.getParameter("redirect") != null) {
			serverSideRedirectURL = java.net.URLDecoder.decode(request.getParameter("redirect"), "UTF-8");
		}
		if (serverSideRedirectURL == null) {
			String app = ServiceNameHelper.getServiceName(getServletContext());
			ComponentEntry componentEntry = venturaConfig.getComponentConfig(app);
			URL configUrl = (request.isSecure() && componentEntry.isSecureUrlEnabled()) ? componentEntry.getSecureServiceUrl() : componentEntry.getServiceUrl();
			serverSideRedirectURL = configUrl != null ? configUrl.toString() : null;
		}
		if (serverSideRedirectURL != null) {
			response.sendRedirect(serverSideRedirectURL);
		}
	}

	if(serverSideRedirectURL == null) {
%><%--
--%><fmt:message key="login.button" var="msgLogin" scope="request" /><%--
--%><fmt:message key="login.user.label" var="username" scope="request" /><%--
--%><fmt:message key="login.password.label" var="password" scope="request" /><%--

--%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html <lc-ui:htmlLanguage />>
<head>
   <meta http-equiv="X-LConn-Login" content="true">
   <meta http-equiv="content-type" content="text/html;charset=UTF-8">
   <meta http-equiv="pragma" content="no-cache">
   <meta http-equiv="cache-control" content="no-cache">
   <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
   <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>

   <title><fmt:message key="login.windowtitle" /></title>

<%--

The following code is to avoid application vulnerable to UI redressing attacks.
It is not allowed to put the application into frame by default. Remove it if customer needs.

--%><lc-ui:framekiller /><%--

=== DO NOT CHANGE ===
--%><script type="text/javascript">
	__iContainer_skip_init__ = true;
</script><%--

--%>

   <lc-ui:stylesheets />
   <lc-ui:favicon />
</head>

<body class="lotusui lotusLogin2 lotusui30_body lotusui30_fonts lotusui30 <lc-ui:languageClassname />">
<div class="lotusui30_layout">
   <div role="banner" class="lotusBanner"><div class="lotusRightCorner"><div class="lotusInner"><div class="lotusLogo" id="lotusLogo"><span class="lotusAltText"><fmt:message key="login.connections.heading"/></span></div></div></div></div>

   <div class="lotusLoginBox lotusLoginBoxWide">
      <div id="loginContent" class="lotusLoginContent">
         <div role="complementary" aria-labelledby="loginContent">
            <%--

            This is the left column of the login page.  Use this section to display information about your deployment.
            --%>
            <%--
            <h2 class="lotusHeading2"><fmt:message key="login.description.title" /></h2>
            <p><fmt:message key="login.description">
               <fmt:param><a href="http://www-306.ibm.com/software/lotus/products/connections/" aria-label="<fmt:message key="login.description.label" />"><fmt:message key="login.description.link" /></a></fmt:param>
            </fmt:message></p>
            <h2 class="lotusHeading2"><fmt:message key="login.description2.title" /></h2>
            <p><a href="<c:out value="${urlHelp}"/>/SSYGQH_KCCI/user/eucommon/euframe.dita"><fmt:message key="login.description2" /></a></p>
          --%><!-- Commented out default -->
          <h1 class="customLoginHeading">Welcome to Circinus</h1>
         </div>
         <form class="lotusForm2 lotusLoginForm" role="main" method="post" action="<c:out value="${loginPostUri}" />">
            <%--

            This is the right column of the login page and contains the login form.
            --%>
            <%-- <h1 class="lotusHeading"><fmt:message key="login.title" /></h1> --%>

            <input id="service.name" type="hidden" name="service.name" value="<c:out value="${serviceName}" />">
            <input id="secure" type="hidden" name="secure" value="<c:out value="${isSecure}" />">
            <input id="fragment" type="hidden" name="fragment" value="<c:out value="${fragmentParameter}" />">
            <c:if test="${hasRedirect}"><input id="redirect" type="hidden" name="redirect" value="<c:out value="${redirectParameter}" />"></c:if>

            <c:if test="${loginError}"><div id="loginError" class="lotusFormError"><fmt:message key="login.error" /></div></c:if>

            <p class="lotusFormField">
               <label for="username"><fmt:message key="login.user.label" /></label>
               <input id="username" placeholder="<c:out value="${username}" />" aria-required="true" <c:if test="${loginError}">aria-invalid="true"</c:if> class="lotusText" type="text" name="j_username">
            </p>
            <p class="lotusFormField">
               <label for="password"><fmt:message key="login.password.label" /></label><%--
                 Note: the autocomplete="off" attribute prevents the browser from saving the password. Remove if you want to allow autocomplete
               --%><input id="password" placeholder="<c:out value="${password}" />" aria-required="true" <c:if test="${loginError}">aria-invalid="true"</c:if> class="lotusText" type="password" name="j_password" autocomplete="off">
            </p>

            <span class="lotusRight" aria-hidden="true"><img role="presentation" src="<lc-ui:blankGif />" alt="" class="lotusIBMLogo"><span class="lotusAltText">IBM</span></span>
            <div class="lotusBtnContainer"><input type="submit" class="lotusBtn lotusBtnSpecial" value="<c:out value="${msgLogin}" />"></div>
         </form>
   		<table class="lotusLegal lotusLoginBoxWide" role="contentinfo"><tr><td class="lotusLicense"><fmt:message key="login.legal" /></td></tr></table>
      </div>
   </div>
 </div>

	<lc-ui:dojo include="lconn.core.bundle_common" />

   <%--
   This section is necessary to preserve URL information when the login page is shown in Files, Wikis, and Activities.
   === DO NOT CHANGE ===
   --%>
   <script type="text/javascript">
      dojo.addOnLoad(function() {
         var fragment = window.location.hash;
         if (fragment) {
            if (fragment.indexOf("#") == 0)
               fragment = fragment.substring(1);
            var input = document.getElementById("fragment");
            input.value = input.value || fragment;
         }

	  <%--
      Assign focus to the username field only if username or password fields not already focused
      --%>
         try {
            var _u = dojo.byId('username'), _p = dojo.byId('password');
            if (dojo.indexOf([_u, _p], document.activeElement) === -1)
               _u.focus();
         } catch (e) {}
      <c:if test="${loginError}">
         setTimeout(function() {try {document.getElementById("loginError").setAttribute("role", "alert");} catch (e) {}}, 100);
      </c:if>

      <c:if test="${hasRedirect}">
         var redirect = findRedirectInFragment("<lc-ui:escapeJavaScript value="${redirectParameter}" />","<lc-ui:escapeJavaScript value="${redirectBase}" />","<lc-ui:escapeJavaScript value="${redirectQuery}" />");
         <%--
         This function identifies any fragment value in the current URL (everything after #) and then inserts it into the current
         redirect value
         @returns The correct redirect value
         --%>
         function findRedirectInFragment(redirect, base, query) {
            var hash = window.location.hash;
            if (hash) {
               hash = hash;
               if (hash.length > 0) {
                  if (hash.charAt(0) == "#")
                     hash = hash.substring(1);
                  var queryMarker = hash.indexOf("?");
                  if (queryMarker != -1) {
                     query += (query.length > 0 ? "&" : "") + hash.substring(queryMarker+1);
                     hash = hash.substring(0,queryMarker);
                  }
                  if (hash.charAt(0) == "/" && base.charAt(base.length-1) == "/")
                     hash = hash.substring(1);
                  base += hash;
                  redirect = base + (query.length > 0 ? ("?"+query) : "");
               }
            }
            return redirect;
         }
         <c:if test="${isAuthenticated}">
            window.location.replace(redirect);
         </c:if>
      </c:if>
      });
   </script>
</body>
</html>
<% } %>
</lc-ui:bundle>
