dojo.provide("com.ibm.lconn.sharepoint.SharepointIntf");dojo.requireLocalization("com.ibm.lconn.sharepoint", "sharepointStrings");dojo.require("dojox.validate.regexp");dojo.declare("SharepointIntfScope", null, {
_resourceBundle : dojo.i18n.getLocalization("com.ibm.lconn.sharepoint",
"sharepointStrings"),
userName : "TESTENV\test",
userPassword : "SomePW423", // @
servername : "dubxpcvm194.mul.ie.ibm.com",
filePath : "/sites/col/Shared%20Documents/Forms/",
fileName : "AllItems.aspx", // ?
urlParameters : "ibm_con_team=true&version=2013",
widgetUri : null,
imagePath : null,
contentDiv : null,
frame_height:0,
loadingDiv : null,
messageTypes : {
ERROR : 0,
WARNING : 1,
INFO : 2,
CONFIRM : 3
},
blankGif : dojo.config.blankGif || dijit._Widget.prototype._blankGif,
config_error_div : "config_error_msg",
config_save_div : "saved_confirmation",
_getMessageNode : function(div) {
var node=dojo.byId(div);if (node) {
return node;} else {
return null;}},
setMessage : function(messageType, message, msgDiv) {
var node;var icon, iconAlt;if (node=this._getMessageNode(msgDiv)) {
node.innerHTML='';switch (messageType) {
case this.messageTypes.ERROR:
node.className='lotusMessage2';icon='lotusIcon lotusIconMsgError';iconAlt='Error';break;case this.messageTypes.WARNING:
node.className='lotusMessage2 lotusWarning';icon='lotusIcon lotusIconMsgWarning';iconAlt='Warning';break;case this.messageTypes.INFO:
node.className='lotusMessage2 lotusInfo';icon='lotusIcon lotusIconMsgInfo';iconAlt='Information';break;default:
node.className='lotusMessage2 lotusSuccess';icon='lotusIcon lotusIconMsgSuccess';iconAlt='Success';};var iconNode=dojo.create('img', {
'src' : this.blankGif,
'class' : icon,
'alt' : iconAlt
});var spanNode=dojo.create('span', {
'class' : 'lotusAltText',
'innerHTML' : iconAlt + ':'
});var messNode=dojo.create('div', {
'class' : 'lotusMessageBody'
});if (message && typeof message == 'string')
messNode.appendChild(document.createTextNode(message));else
messNode.appendChild(message);node.appendChild(iconNode);node.appendChild(spanNode);node.appendChild(messNode);if (this.messageTypes.ERROR != messageType) {
var delButton=dojo.create("a", {
'href' : 'javascript:void(0);',
'role' : 'button',
'title' : "Close",
'class' : 'lotusDelete'
});dojo.connect(delButton, 'onclick', function(evt) {
node.className='lotusMessage2 lotusHidden';node.innerHTML='';});var delIconNode=dojo.create('img', {
'src' : this.blankGif,
'alt' : "Close"
});var delSpanNode=dojo.create('span', {
'class' : 'lotusAltText',
'innerHTML' : 'X'
});delButton.appendChild(delIconNode);delButton.appendChild(delSpanNode);node.appendChild(delButton);dojo.removeClass(node, 'lotusHidden');}}},
removeMessageNode : function() {
if (node=this._getMessageNode()) {
dojo.addClass(node, 'lotusHidden');}},
onLoad : function() {
widgetUri=this.iContext.io._widgetBaseUri;imagePath=widgetUri + "image/loading.gif";},
switchViewMode : function(mode) {
this.iContext.iEvents.fireEvent("onModeChanged", "", "{'newMode': '"
+ mode + "'}");},
cancelEditForm : function() {
this.switchViewMode(this.iContext.constants.mode.VIEW);},
onEdit : function() {
console.info("on edit view invoked");var inputSave=this.iContext.getElementById("SP_save_btn");inputSave.value=this._resourceBundle.SAVE_BTN;var inputCancel=this.iContext.getElementById("SP_cancel_btn");inputCancel.value=this._resourceBundle.CANCEL_BTN;var new_url=this.iContext.getiWidgetAttributes().getItemValue("url");dojo.byId("editSharepointURL").value=new_url;var new_style=this.iContext.getiWidgetAttributes().getItemValue(
"css_style");var select=dojo.byId("cssStyle");var options=select.options;for (var i=0; i < options.length; i++) {
if (options[i].value === new_style) {
select.selectedIndex=i;break;}};},
ProcessForm : function() {
console.info("Process form invoked");var url=this.iContext.getElementById("editSharepointURL").value;if (url == null || url == "") {
this.iContext.getElementById("editSharepointURL").focus();this.setMessage(this.messageTypes.ERROR,
this._resourceBundle.URL_ERROR, "edit_feedback");return false;}if (this.isvalidURL(url) < 1) {
console.info("URL IS INVALID INVOKED:");this.iContext.getElementById("editSharepointURL").focus();this.setMessage(this.messageTypes.ERROR,
this._resourceBundle.URL_INVALID, "edit_feedback");return false;}else {
this.SaveUrlConfig();};},
isvalidURL : function(url) {
console.info("Checking URL...:");var pattern=new RegExp('^(https?:\\/\\/)?' + // protocol
'((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.?)+[a-z]{2,}|' + // domain name
'((\\d{1,3}\\.){3}\\d{1,3}))' + // OR ip (v4) address
'(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*' + // port and path
'(\\?[;&a-z\\d%_.~+=-]*)?' + // query string
'(\\#[-a-z\\d_]*)?$', 'i'); // fragment locator
var result=pattern.test(url);console.info("URL RESULT:" + result);return pattern.test(url);},
SaveUrlConfig : function() {
console.info("validation passed: Saving.....");var url;var css_style;var css_values;url=this.iContext.getElementById("editSharepointURL").value;css_values=this.iContext.getElementById("cssStyle");css_style=css_values.options[css_values.selectedIndex].value;this.save_SharepointURL(url);this.save_CSS_Style(css_style);this.repopulate_edit_page();this.setMessage(this.messageTypes.CONFIRM,
this._resourceBundle.SAVE_SUCCESS, "edit_feedback");},
save_SharepointURL : function(url) {
console.info("Save_sharepointURL invoked.....");var attrs=this.iContext.getiWidgetAttributes();attrs.setItemValue("url", url);attrs.save();},
save_CSS_Style : function(style) {
console.info("Save_CSS_STYLE invoked.....");var new_style=this.iContext.getiWidgetAttributes().getItemValue(
"css_style");if (new_style == 'custom') {
css_url=this.iContext.getElementById("customCSSURL").value;var attrs=this.iContext.getiWidgetAttributes();attrs.setItemValue("css_url", css_url);attrs.save();}var attrs=this.iContext.getiWidgetAttributes();attrs.setItemValue("css_style", style);attrs.save();},
repopulate_edit_page : function() {
console.info("REPOPULATE page invoked......");var new_url=this.iContext.getiWidgetAttributes().getItemValue("url");this.iContext.getElementById("editSharepointURL").value=new_url;var new_style=this.iContext.getiWidgetAttributes().getItemValue(
"css_style");var select=this.iContext.getElementById("cssStyle");var options=select.options;for (var i=0; i < options.length; i++) {
if (options[i].value === new_style) {
select.selectedIndex=i;break;}};},
onView : function() {
console.info("onView was invoked.");if (!this.iContext.getiWidgetAttributes().getItemValue("url")|| !this.iContext.getiWidgetAttributes().getItemValue("css_style")) {
this.setMessage(this.messageTypes.ERROR,
this._resourceBundle.NO_CONFIG_SET, "view_msg_feedback");} else {
this.Viewpage_mode_Loading();};},
onFullpage : function() {
console.info("FullPagemode inVoked");if (!this.iContext.getiWidgetAttributes().getItemValue("url")|| !this.iContext.getiWidgetAttributes().getItemValue("css_style")) {
this.setMessage(this.messageTypes.ERROR,
this._resourceBundle.NO_CONFIG_SET, "view_msg_feedback");return;}var url=this.iContext.getiWidgetAttributes().getItemValue("url");if (this.isvalidURL(url) < 1) {
console.info("URL IS INVALID INVOKED:");this.setMessage(this.messageTypes.ERROR,
this._resourceBundle.URL_IS_INVALID, "view_msg_feedback");return;}else {
console.info("Full page mode: URL IS PRESENT & VALID");this.Fullpage_mode_Loading();var iframe_src=this.iContext.getiWidgetAttributes().getItemValue("url");iframe_src+="?ibm_embedded=true";var css_style=this.iContext.getiWidgetAttributes().getItemValue(
"css_style");iframe_src+="&ibm_css_style=" + css_style;if (css_style == 'custom') {
custom_css_url=this.iContext.getiWidgetAttributes()
.getItemValue("css_url");iframe_src+="&ibm_custom_css_url=" + custom_css_url;}if (css_style == 'style1' || css_style == 'style2') {
iframe_src+="&ibm_custom_css_url=" + widgetUri + "css";}iframe_src+="&parent_url=" + document.URL;body_onload=dojo.hitch(this,this.body_loaded);dojo.byId("pc3").src=iframe_src;dojo.byId("pc3").onload=function () {
body_onload(iframe_src);};window.addEventListener("message",dojo.hitch(this,this.receiveMessagefromFrame), false);};console.info("FullPagemode invoked Ended");},
body_loaded : function(iframe_src){
this.SendMessageToIframe("ibm_set_information|"+iframe_src.split("?")[1]);},
receiveMessagefromFrame : function(event){
if(this.iContext.getiWidgetAttributes().getItemValue("url").indexOf(event.origin)>-1){
if(event.data.toString().split('|')[0]=="ibm_iframe_loading"){
dojo.byId('loadingDiv').style.display='block';dojo.byId('pc3').style.display='none';}else if(event.data.toString().split('|')[0]=="ibm_iframe_loading_done"){
dojo.byId('pc3').style.display='block';dojo.byId('loadingDiv').style.display='none';if(this.frame_height!=0){
this.SendMessageToIframe("get_height_width|height:"+(this.frame_height).toString());}else{
this.SendMessageToIframe("get_height_width|height:0");};}else if(event.data.toString().split('|')[0]=="ibm_iframe_height_width"){
dojo.byId('pc3').height=event.data.toString().split('|')[1].split(",")[0].split(":")[1];this.frame_height=dojo.byId('pc3').height;dojo.byId('pc3').width=event.data.toString().split('|')[1].split(",")[1].split(":")[1];}else if(event.data.toString().split('|')[0]=="are_you_from_ibm"){
if(event.data.toString().split('|')[1]=="surpass_ibm_set_information")
this.SendMessageToIframe("yes_im_from_ibm|call_func_on_load");else if(event.data.toString().split('|')[1]=="")
this.SendMessageToIframe("yes_im_from_ibm|wait_till_func_load");}}else
console.log("Something wrong, message receive is not from desired URL");},
SendMessageToIframe : function(data_to_sent){
var a_getHostname=dojo.create("a");a_getHostname.href=this.iContext.getiWidgetAttributes().getItemValue("url");console.log("Posting Message to Frame -----------------------------");iframe=dojo.byId('pc3');if(a_getHostname.port.toString()!=""){
iframe.postMessage(data_to_sent,a_getHostname.protocol.toString()+"//"+a_getHostname.hostname.toString()+":"+a_getHostname.port.toString());
}else{
iframe.postMessage(data_to_sent,a_getHostname.protocol.toString()+"//"+a_getHostname.hostname.toString());
};dojo.destroy(a_getHostname);},
Viewpage_mode_Loading : function() {
dojo.query(".loadingimg").style({
"backgroundImage" : "url(" + imagePath + ")",
"display" : "block"
});},
Viewpage_ConfigError : function() {
console.info("Viewpage config error invoked...");var config_error=this._resourceBundle.NO_CONFIG_SET;dojo.query(".config_error_msg").forEach(function(node, index, arr) {
node.innerHTML=config_error;});},
Fullpage_mode_Loading : function() {
var load_msg=this._resourceBundle.LOADING_MSG;dojo.query(".loadingimg").forEach(
function(node, index, arr) {
dojo.style(node, {
"display" : "block"
});node.innerHTML="<img src=\"" + imagePath
+ "\" class=\"full_load\"/>" + " " + load_msg
+ "...";});dojo.byId('pc3').style.display='none';},
createView : function() {
},
hideLoadingMessage : function() {
},
});