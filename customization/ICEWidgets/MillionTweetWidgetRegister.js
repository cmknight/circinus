millionTweetWidget: function() {

  function myCustomWidget(container$, widgetData) {
    XCC.require(["/xcc/rest/public/custom/MillionTweetWidget.js"], function(millionTweetWidget) {
      millionTweetWidget.widget(container$, widgetData);
    });
  }

  function myCustomEditor(container$, widgetData) {
     XCC.require(["/xcc/rest/public/custom/MillionTweetWidget.js"], function(millionTweetWidget) {
       millionTweetWidget.editor(container$, widgetData);
     });
   }

  function save(container$, widgetData) {
   XCC.require(["/xcc/rest/public/custom/MillionTweetWidget.js"], function(millionTweetWidget) {
     millionTweetWidget.save(container$, widgetData);
   });
 }



  XCC.W.registerCustomWidget("MillionTweetWidget Widget", "table", myCustomWidget, myCustomEditor, save);
}
