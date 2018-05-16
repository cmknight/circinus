/**!
 * Banner.js - IBM Connections Engagement Center (ICEC)
 *
 * Shows up an image which links to an url.
 * Optional you can set an abstract.
 *
 * @copyright Copyright IBM Corp. 2017, 2017 All Rights Reserved
 *
 * @author Christian Luxem (CLU)
 * @author CMK
 * @depends jQuery, lightbox
 *****************************************************************************/
/*jslint browser:true,white:true,multivar:true,this:true,fudge:true,single:true*/
/*global XCC, jQuery, window*/
/*exported BannerWidget */
(function ($, W) {
	"use strict";

	var X = (function () {W.XCC = W.XCC || {}; return W.XCC; }()); // get or create and expose the XCC Object

	/**
	 * @param wBox$ {Jquery-Object} The HTMl-Container
	 * @param {Objekt} [data] The contentStream...
	 */
	function myMillionTweetWidget(wBox$, widgetData) {
    console.log(widgetData);
		var contDiv$ = $('<div id="widgetDiv"></div>');
		$.get("/MillionTweetApp/map/includes.html", function (data) {
			wBox$.append(data);
		})

		if(widgetData.height) {
			contDiv$.css( "height", ""+widgetData.height+"" );
		}
		$.get("/MillionTweetApp/map/index.html", function (data) {
			//var resultDiv$ = $('<div id="mapWrap"></div>');
			//if(widgetData.height) {
			//	resultDiv$.css( "min-height", ""+widgetData.height+"" );
			//}
			//resultDiv$.html(data);
			//contDiv$.append(resultDiv$);
			contDiv$.append(data);
		})

		wBox$.append(contDiv$);
		window.dispatchEvent(new Event('resize'));
		X.T.triggerEventsForWidget(widgetData, wBox$);
	} // END BannerWidget

	function save(container$, widgetData) {
		console.log('save:');
		console.log(widgetData);
		 // find the new values in the container and save them
		 widgetData.title = container$.find("input[name=title]").val();
		 widgetData.height = container$.find("input[name=height]").val();
		 // persist the values as a property of this widget
		 //XCC.T.setXccPropertyString(widgetData, "millionTweetWidgetConfig");
	 }

	 function millionTweetEditor (container$, widgetData) {
		 console.log('millionTweetEditor:');
		 console.log(widgetData);
				return [XCC.U.createTextInputOnTheFly("widget Title ", widgetData.title, "title"),
				XCC.U.createTextInputOnTheFly("Height", widgetData.height, "height")];
			}

	// define this function in
	XCC.define([], function () {
		 return {
				 widget: myMillionTweetWidget,
				 editor:millionTweetEditor,
				 save:save
		 };
	 }); // END X.define
} (XCC.jQuery || jQuery, window));
