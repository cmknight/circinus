/* ***************************************************************** */
/*                                                                   */
/* IBM Confidential                                                  */
/*                                                                   */
/* OCO Source Materials                                              */
/*                                                                   */
/* Copyright IBM Corp. 2007, 2015                                    */
/*                                                                   */
/* The source code for this program is not published or otherwise    */
/* divested of its trade secrets, irrespective of what has been      */
/* deposited with the U.S. Copyright Office.                         */
/*                                                                   */
/* ***************************************************************** */

//dojo.require("dojo.dnd.*");
dojo.require("com.ibm.enabler.debug");
dojo.declare("stock",null,{
	onLoad: function () {
        com.ibm.enabler.debug.log("test.onLoad ",this.iContext.getRootElement().getAttribute("id"));
    },
    handlePublish:function(){
         var widgetId = this.iContext.getRootElement().getAttribute("id");

         if (widgetId == "2") {
             var widgetStub = serviceManager.getService("queryService").getWidgetById("2");
             this.testQueryService(widgetStub);
             var arr = serviceManager.getService("queryService").getWidgetsByDefUrl("http://localhost:8080/iwidgets/helloworldwidget/helloworld1.xml");

             serviceManager.getService("eventService").publishWire("1","testRuntimeWiring");
         }
    },
    handleRuntimeWiring:function(){
         com.ibm.enabler.debug.entry("Test.handleRuntimeWiring");
         var aPayload = this.iContext._getPayloadDef("location");
         if (typeof aPayload != "undefined" && aPayload != null) {
             com.ibm.enabler.debug.log("Test.handleRuntimeWiring","aPayload name:"+aPayload.name+" payloadobject:"+aPayload);
             var children = aPayload.getChildren();
             var aChild;
             for ( aChild in children) {
                 com.ibm.enabler.debug.log("Test.handleRuntimeWiring","aPayload child name: "+aChild);
             }
         }
    },
    testQueryService:function(widgetStub){
         com.ibm.enabler.debug.log("Test.testQueryService",this.iContext.getRootElement().getAttribute("id"));
         com.ibm.enabler.debug.log("Test.testQueryService","widgetStub:",widgetStub);
         com.ibm.enabler.debug.log("Test.testQueryService", "rootElement:"+widgetStub.rootElement);

         com.ibm.enabler.debug.log("Test.testQueryService","testRuntimeWiring:"+widgetStub.getPublishedEvent("testRuntimeWiring"));
         var eventsArr = widgetStub.getPublishedEvent("testRuntimeWiring");
         var event;
         for (event in eventsArr ) {
             com.ibm.enabler.debug.log("Test.testQueryService","testRunttimeWiring wires:"+eventsArr[event].wires);
         }
         var wires = widgetStub.getWires();
        com.ibm.enabler.debug.log("Test.testQueryService","testRunttimeWiring wires:"+wires.length);
        for (var j=0;j<wires.length;j++) {
            com.ibm.enabler.debug.log("Test.testQueryService","testRunttimeWiring wire "+wires[j].SourceWidget+" "+wires[j].SourceEvent+" "+wires[j].TargetEvent);
        }

         var attributes = widgetStub.getAttributes();
         com.ibm.enabler.debug.log("Test.testQueryService","getSupportedModes supportedModes:"+attributes.getItemValue("supportedModes"));
         com.ibm.enabler.debug.log("Test.testQueryService","getAttribute broker:"+attributes.getItemValue("broker"));
         var payloadDefNames = widgetStub.getPayloadDefNames();
         com.ibm.enabler.debug.log("Test.testQueryService","getPayloadDefNames: "+payloadDefNames.length);
         var aPayloadName;
         for ( var i=0;i<payloadDefNames.length;i++) {
             aPayloadName = payloadDefNames[i];
             var aPayload = widgetStub.getPayloadDef(aPayloadName);
             com.ibm.enabler.debug.log("Test.testQueryService","aPayload name:"+aPayloadName+" payloadobject:"+aPayload);
             var children = aPayload.getChildren();
             var aChild;
             for ( aChild in children) {
                 com.ibm.enabler.debug.log("Test.testQueryService","aPayload child name: "+aChild);
             }
         }

     },
    updateQuote:function(iEvent){
          var data = iEvent.payload;
          if (typeof data == "undefined" || data == null) return;

          var company = data.company;
          if (typeof company == "undefined" || company == null) return;

          var element2 = this.iContext.getElementById("company");
          var temp = element2.innerHTML;
          if (temp == company) return;
          element2.innerHTML = company;

          var element = this.iContext.getElementById("stock");
          var oldQuote = parseInt(element.innerHTML);
          if (oldQuote > 100) {
              element.innerHTML = "95";
          }
          else{
              element.innerHTML = "105";
          }
     },
     sendData:function(){
          var data = {};
          data.company = this.iContext.getElementById("company").innerHTML;
          data.stock = this.iContext.getElementById("stock").innerHTML;
          data.broker = this.iContext.getElementById("broker").innerHTML;
          this.iContext.iEvents.fireEvent("sendStockData",null,data);
          
          var iDescriptor = this.iContext.getiDescriptor();
          if (typeof iDescriptor != undefined && iDescriptor != null) {
              console.debug("current mode is "+iDescriptor.getItemValue("mode"));
          }
     },
     editBroker:function(){
          this.iContext.iEvents.fireEvent("onModeChanged",null, "{newMode:'edit'}");
     },
     switchBroker:function(){
          var element = this.iContext.getElementByClass("brokerSelection");
          element = element[0];
          var value = element.options[element.selectedIndex].value;
        
          var iDescriptor = this.iContext.getiDescriptor();
          if (typeof iDescriptor != undefined && iDescriptor != null) {
            console.debug("switch broker: current mode is "+iDescriptor.getItemValue("mode"));
          }

          var attributes = this.iContext.getiWidgetAttributes();
          attributes.setItemValue("broker",value);
          attributes.save();
          this.iContext.iEvents.fireEvent("onModeChanged",null, "{newMode:'view'}"); 
     },
     onview:function(){
          var element = this.iContext.getElementById("stock");
        var attributesItemSet = this.iContext.getiWidgetAttributes();
        element.innerHTML = attributesItemSet.getItemValue("stock");

        var elements = this.iContext.getElementByClass("companyLabel");
        var element2 = elements[0];
        element2.innerHTML = attributesItemSet.getItemValue("company");

        var element3 =this.iContext.getElementById("broker");
        element3.innerHTML = attributesItemSet.getItemValue("broker"); 
     },
     onedit:function(){
          var element = this.iContext.getElementByClass("brokerSelection");
          var attributesItemSet = this.iContext.getiWidgetAttributes();  
          var broker = attributesItemSet.getItemValue("broker");
          if (typeof broker == "undefined" || broker == null) return;
          element = element[0];
          for (var i=element.options.length-1; i >= 0;i--) {
              var value = element.options[i].value;
              if (value != null && value == broker) {
                    element.options[i].selected = true;
              }
          }
     }
});



