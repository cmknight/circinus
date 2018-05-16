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
<%--
--%><lc-ui:bundle basename="com.ibm.lconn.core.strings.templates"><%--
=== DO NOT CHANGE ===

--%><div id="navMenuCirc" aria-label="circ options"><table cellspacing="0" class="lotusLayout" role="presentation"><%--
 --%><tr><%--
		--%><td class="lotusNowrap"><%--
			 --%><a href="/xcc/main?page=landing"><%--
		 --%><fmt:message key="label.circinus.landing" /><%--
			 --%></a><%--
		--%></td><%--
 --%></tr><%--
--%><tr><%--
	--%><td class="lotusNowrap"><%--
--%><a href="/xcc/main?page=Analytics"><%--
--%>Analytics<%--
		 --%></a><%--
	--%></td><%--
--%></tr><%--
--%></table><div class="lotusNavMenuConnector"></div></div><%--

--%></lc-ui:bundle>
