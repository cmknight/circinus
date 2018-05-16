<%-- Copyright IBM Corp. 2011, 2014  All Rights Reserved. --%><%--


   The Connections footer is generated by this JSP.  It is included on every request by most
   services, although Files, Wikis, and Activities will only reload the footer when the page
   is refreshed, and Bookmarks will cache the main page until new bookmarks are added to the
   system or the app is restarted.

=== DO NOT CHANGE ===
--%><%@ page contentType="text/html;charset=UTF-8" %><%--
--%><%@ page import="java.util.Properties" %><%--
--%><%@ page import="com.ibm.connections.mtconfig.ConfigEngine,
    com.ibm.lconn.core.web.util.taglib.ServiceEnabledBean,
    com.ibm.ventura.internal.config.helper.api.VenturaConfigurationHelper" %><%--
--%><%@ taglib prefix="c"        uri="http://java.sun.com/jsp/jstl/core" %><%--
--%><%@ taglib prefix="fmt"      uri="http://java.sun.com/jsp/jstl/fmt" %><%--
--%><%@ taglib prefix="lc-cache" uri="http://www.ibm.com/connections/core/cache" %><%--
--%><%@ taglib prefix="lc-ui"    uri="http://www.ibm.com/lconn/tags/coreuiutil" %><%

boolean isActionCenterEnabled = false;

VenturaConfigurationHelper venturaConfig = VenturaConfigurationHelper.Factory.getInstance();
Properties genericProperties = venturaConfig.getGenericProperites();

if(genericProperties != null) {
	isActionCenterEnabled = "enabled".equals(genericProperties.getProperty("actioncenter"));
	request.setAttribute("isActionCenterEnabled", isActionCenterEnabled);
}

com.ibm.connections.mtconfig.ConfigEngine.useBean(pageContext);

pageContext.setAttribute("languageSettings", com.ibm.ventura.internal.config.helper.api.VenturaConfigurationHelper.Factory.getInstance().getLanguageSelectorSettings());
//pageContext.setAttribute("mobileSettings", com.ibm.lconn.core.mobile.redirect.util.MobileRedirectHelper.getInstance().getMobileRedirectSettings()); %><%--

--%><jsp:useBean id="services" class="com.ibm.lconn.core.web.util.taglib.ServiceEnabledBean" scope="application"/><%--
--%><lc-ui:bundle basename="com.ibm.lconn.core.strings.templates"><%--
=== DO NOT CHANGE ===


   The table footer links are rendered here.  The helper tag <lc-ui:templateLink /> looks
   up a key name (such as "connections.demo") in the

      com.ibm.lconn.core.web.ui.resources.footerlinks

   property bundle.  The tag will generate an <LI> element with either a link or a
   javascript "onclick" handler based on the value of the key.

   The property bundle can be customized using standard Connections string customization -
   see the InfoCenter for more details.

   Footer links are disabled in multitenant enabled configurations.

--%><c:if test="${not mtConfig.enabled}"><%--
--%><div id="removeBlankFooter"></div><%--
--%><ul><%--

         The link to the Homepage.  If Homepage is not installed the "Home" link
         points to the current application

               --%><li><%--
                  --%><c:if test="${services.homepage}"><%--
                     --%><lc-ui:serviceLink serviceName="homepage" var="urlHomepage" /><%--
                     --%><a href="<c:out value="${urlHomepage}/" />"><%--
                        --%><fmt:message key="label.footer.connections.home" /><%--
                     --%></a><%--
                  --%></c:if><%--
                  --%><c:if test="${!services.homepage}"><%--
                     --%><a href="${pageContext.request.contextPath}/"><%--
                        --%><fmt:message key="label.footer.connections.home" /><%--
                     --%></a><%--
                  --%></c:if><%--
               --%></li><%--


         The help links.  Points to the end-user help for the current application, and to the
         public IBM forums for IBM Connections

               --%><lc-ui:templateLink key="help.help" appname="${appName}"><fmt:message key="label.footer.help.help" /></lc-ui:templateLink><%--
               --%><li><%--
                  --%><a href="<c:out value="http://www-10.lotus.com/ldd/lcforum.nsf" />"><%--
                     --%><fmt:message key="label.footer.help.forums" /><%--
                  --%></a><%--
               --%></li><%--


         The tool links.  The browser plugin link is the "How to Bookmark" link which appears
         in most but not all applications.  The metrics link is displayed to users in the
         metrics-reader role (which is 'Everyone' by default) and shows statistical info about
         each application.

               --%><c:if test="${services.bookmarklet}"><%--
               --%> <lc-ui:templateLink key="tools.browserplugins" appname="${appName}"><fmt:message key="label.footer.tools.browserplugins" /></lc-ui:templateLink><%--
               --%></c:if><%--
               --%><lc-ui:templateLink key="tools.adminpage" className="lotusAdminLink" appname="${appName}" test="${isAdmin}"><fmt:message key="label.footer.tools.adminpage" /></lc-ui:templateLink><%--

               --%><c:if test="${services.metrics}"><%--
                  --%><li id="lotusBannerFooterMetrics" style="display:none"><%--
                      --%><lc-ui:serviceLink serviceName="metrics" var="urlMetrics" /><%--
                      --%><a class="lotusMetricsReaderLink" href="<c:out value="${urlMetrics}/" />"><%--
                          --%><fmt:message key="label.footer.tools.metrics" /><%--
                      --%></a><%--
                  --%></li><%--
               --%></c:if><%--


         The mobile UI link gives a chance to mobile clients who chose to browse the desktop UI to switch back to the mobile UI.

               --%><c:if test="${services.mobile}"><%--
                  --%><li id="lconnFooterMobile" class="lotusHidden"><%--
                      --%><a id="lconnMobileRedirectLink" href="javascript:;"><%--
                          --%><fmt:message key="label.footer.tools.mobileui" /><%--
                      --%></a><%--
                  --%></li><%--
               --%></c:if><%--

         The about links point to the IBM.com IBM Connections product site and the public
         feedback forum.

               --%><lc-ui:templateLink key="about.about" appname="${appName}"><fmt:message key="label.footer.about.about" /></lc-ui:templateLink><%--
               --%><li><%--
                  --%><a href="<c:out value="http://www-306.ibm.com/software/lotus/products/connections/" />"><%--
                     --%><fmt:message key="label.footer.about.connectionsonline" /><%--
                  --%></a><%--
               --%></li><%--
               --%><li><%--
                  --%><a href="<c:out value="http://www.lotus.com/ldd/doc/cct/nextgen.nsf/feedback_choice?OpenForm&Context=footer+ventura+NoTitle+4.5" />"><%--
                     --%><fmt:message key="label.footer.about.submitfeedback" /><%--
                  --%></a><%--
               --%></li><%--
            --%></ul><%--

--%></c:if><%--


   Some applications do not load authentication information until the page loads.
   For these applications, we provide a callback that allows the application to
   inform us if the user is logged in.  If the header and footer are customized
   this logic must also be changed.

=== DO NOT CHANGE ===
--%><c:if test="${appName == 'dogear' || appName == 'blogs' || appName == 'forums'}"><%--
--%><fmt:message var="logoutLabelText" key="label.header.logout" scope="page" /><%--
--%><script type="text/javascript">
(function() {
   function handleHeaderInit(info) {
      lconn.core.header.decorateUser( /*user*/ {
         displayName: info.user,
         id: info.userId
      }, /*urls*/ {
         logout: '<lc-ui:escapeJavaScript value="${logoutLink}" />',
         user_jsp: '<lc-cache:uri template="{staticLanguageRoot}/nav/templates/menu/user.jsp" />?appName=${appName}&username=${username}&userid=${username}',
         communities_jsp: '<lc-cache:uri template="{staticLanguageRoot}/nav/templates/menu/communities.jsp?authenticated=true" script="true" />'
      }, /*strings*/ {
         logout: '<lc-ui:escapeJavaScript value="${logoutLabelText}" />'
      });
   }
   dojo.subscribe("lconn/core/header/init", handleHeaderInit);
})();
</script><%--
--%></c:if><%--
=== DO NOT CHANGE ===

   Script for language selector insertion into the header. Dojo will be loaded
   prior to the header, but not all application Javascript may be available.
   Some applications may not load the language selector immediately after the
   page loads (Files/Wikis).

=== DO NOT CHANGE ===
--%><c:if test="${languageSettings.enabled}"><%--

--%><script type="text/javascript">
(function(){
   function loadConnectionsLanguageSelector() {
      try {
         dojo.require("lconn.core.header");
         lconn.core.header.enableLanguageSelector("languageSelectorText", ${languageSettings.languagesAsJSONString},
            "${languageSettings.cookieName}", "${languageSettings.cookieDomain}", ${languageSettings.cookieTimeout});
      } catch (e) {
         console.error(e);
      }
   }
   if (dojo.exists("lconn.core.header") && !dojo.exists("_skipConnectionsLanguageSelector"))
      dojo.addOnLoad(loadConnectionsLanguageSelector);
})();
</script><%--

--%></c:if><%--
=== DO NOT CHANGE ===

Some apps e.g. communities, metrics do not load bundle_common.
Force load essential scripts here
--%><script type="text/javascript">
      dojo.require("lconn.core.header.apps");
      dojo.require("lconn.core.auth");
<%--
      dojo.require("lconn.core.mobile");
      lconn.core.mobile.detect("${mobileSettings.cookieName}");
--%>
    </script><%--

// Loading Action Center Bundle if Orient and Action Center enabled
--%><c:if test="${services.orient && isActionCenterEnabled}"><%--
	--%><script type="text/javascript">
		if (lconn.core != undefined) {
			if (!lconn.core.config.services.orient.url.includes(window.location.href.split("/")[3])) {
				var head = document.getElementsByTagName('head')[0];
				var js = document.createElement("script");
				js.type = "text/javascript";

				var css = document.createElement('link');
			    css.setAttribute('type', 'text/css');
			    css.setAttribute('rel', 'stylesheet');
			    var rtlTextEnabled = document.getElementsByTagName('html')[0].dir === 'rtl';

				if (window.location.protocol == 'https:') {
					js.src = lconn.core.config.services.orient.secureUrl + '/resources/actioncenter/actioncenter.bundle.js?etag=' + lconn.core.config.versionStamp;
					if (rtlTextEnabled) {
						css.href = lconn.core.config.services.orient.secureUrl + '/resources/actioncenter/actioncenter-styles.rtl.css?etag=' + lconn.core.config.versionStamp;
					} else {
						css.href = lconn.core.config.services.orient.secureUrl + '/resources/actioncenter/actioncenter-styles.css?etag=' + lconn.core.config.versionStamp;
					}
				} else {
					js.src = lconn.core.config.services.orient.url + '/resources/actioncenter/actioncenter.bundle.js?etag=' + lconn.core.config.versionStamp;
					if (rtlTextEnabled) {
						css.href = lconn.core.config.services.orient.url + '/resources/actioncenter/actioncenter-styles.rtl.css?etag=' + lconn.core.config.versionStamp;
					} else {
						css.href = lconn.core.config.services.orient.url + '/resources/actioncenter/actioncenter-styles.css?etag=' + lconn.core.config.versionStamp;
					}
				}

				head.appendChild(js);
				head.appendChild(css);

				window.addEventListener("message", function(event) {
					if (event.data === "com/ibm/social/as/notification/action/center/loaded") {
						ActionCenter.actionCenterLoader();
					}
				});
			}
		}
				</script> <%--
--%></c:if><%--

--%><c:if test="${hasUsername}"><%--
   --%><script type="text/javascript">
         dojo.addOnLoad(function(){
            lconn.core.header.apps.updateLoginRegion();
            lconn.core.header.apps.updateBannerByRoles();
         });
       </script><%--
--%></c:if><%--
--%><script type="text/javascript">

require(['dojo/query', 'dojo/_base/window', 'dijit/Tooltip', 'dojo/ready', "dojo/request/notify", "ic-core/config/features", "dijit/registry"], function(query, win, Tooltip, ready, notify, has, registry){
    var timeOutId;
    ready(1200, function(){
    	if(has("common-tooltip")){
        var interval = setInterval(function() {

            query('*[title]').forEach(function(node, index, arr, ready){
            	if(!node.getAttribute("skipAutoTooltip")){
	                if(node.getAttribute("hastooltip")){
	                  var oldTooltip = registry.byId(node.getAttribute("hastooltip"));
	                  if(oldTooltip){
	                    oldTooltip.destroy();
	                  }
	                }
	                var tooltip = new Tooltip({
	                  connectId: [node],
	                  label: node.title,
	                  position: ["above", "below"]
	                });
	                node.setAttribute("hastooltip", tooltip.id);
            	}
            });
        },100);
        setTimeout(
            function( ) {
            clearInterval(interval);
                document.body.addEventListener('DOMNodeInserted', function(ev){
                  if (ev.target) {
                    if(ev.target.nodeType === 3){
                      return;
                    }
                    var widget;
                    try {
                        widget = registry.byNode(ev.target);
                    } catch (e) {
                      // ignoring. triggered by nodes which doesn't hold a widget
                    }
                    if (widget && dijit._MasterTooltip.prototype.isPrototypeOf(widget)) {
                      return;
                    }
                  }
                    if(timeOutId){
                      clearTimeout(timeOutId);
                    }
                    timeOutId = setTimeout(function(){
                      query('*[title]').forEach(function(node, index, arr, ready){
                    	  if(!node.getAttribute("skipAutoTooltip")){
							if(node.getAttribute("hastooltip")){
							  var oldTooltip = registry.byId(node.getAttribute("hastooltip"));
							  if(oldTooltip){
							    oldTooltip.destroy();
							  }
							}
							var tooltip = new Tooltip({
							  connectId: [node],
							  label: node.title,
							  position: ["above", "below"]
							});
							node.setAttribute("hastooltip", tooltip.id);
                    	  }
                      });
                    }, 500);
                }, true);
        }, 6000);
    	}
    });
});
</script>

<!-- CMK IN FOOTER.JSP --><%--
--%></lc-ui:bundle>