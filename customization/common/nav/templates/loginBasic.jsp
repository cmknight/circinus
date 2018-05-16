<%-- Copyright IBM Corp. 2011  All Rights Reserved. 

   This JSP outputs the headers necessary to trigger BASIC authentication in a web browser. 
   
--%><%@ page import="com.ibm.lconn.core.web.auth.LCRestSecurityHelper, 
                    com.ibm.ventura.internal.config.api.VenturaConfigurationProvider, 
                    com.ibm.ventura.internal.config.helper.api.VenturaConfigurationHelper" 
%><%

VenturaConfigurationHelper helper = VenturaConfigurationHelper.Factory.getInstance();
VenturaConfigurationProvider provider = VenturaConfigurationProvider.Factory.getInstance();
String serviceName = getServletContext().getInitParameter("service.name");
if (serviceName == null || serviceName.trim().length() == 0) {
   throw new ServletException("The servlet context init parameter 'service.name' must be set");
}

if (!request.isSecure() && (helper.getForceConfidentialCommunications() || provider.isSecureServiceEnabled(serviceName))) {
   String url = LCRestSecurityHelper.getSslVersionOfCurrentUrl(request, serviceName);
   response.sendRedirect(url);
   return;
}

response.setHeader("Pragma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
response.addHeader("Cache-Control","private,no-store,max-stale=0");

response.setStatus(401);
response.setHeader("WWW-Authenticate","Basic realm=\"lotus-connections\"");

%>
