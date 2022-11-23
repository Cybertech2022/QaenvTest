({
    // Toast Message
    showToast: function(title, message, error) {
        let toastParams = {
            title: title,
            message: message,
            type: error
        };
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams(toastParams);
        toastEvent.fire();
    },
    
    // Get Account Name
    getAccountName: function(component, event, helper, topicName, currentRecordId) {
        var action = component.get("c.getAccountName");
        action.setParams({
            name: topicName,
            recordId: currentRecordId
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {   
                var getValues = response.getReturnValue();
                var salution = getValues[0].Salutation;
                var AccountName = getValues[0].Name;
                this.showToast(
                    "Success !",
                    " "+topicName+" Tag is assigned to "+ AccountName,
                    "success"
                );  
            } else {
                alert("Failed : " + JSON.stringify(response.getError()));
            }
        });
        
        $A.enqueueAction(action);
    },
    
    // Get Topic Name
    getTopicName: function(component, event, helper, currentRecordId, isModel){
        var action = component.get("c.getTopicName");
        
        action.setParams({
            recordId: currentRecordId,
            model: isModel
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var items = [];
                var getValues = response.getReturnValue();
                for (var i = 0; i < getValues.length; i++) {
                    var topicId = getValues[i].Id;
                    var topicName = getValues[i].Name;
                    var topicAssignments = getValues[i].TopicAssignments;
                    items.push("m_"+topicName);
                    if(topicAssignments == undefined){
                        this.createComponentButton(component, event, helper, topicId, topicName, isModel); 
                    }                    
                }                 
                if(isModel == "nonmodel"){
                    this.createComponentMoreButton(component, event, helper); 
                    component.set("v.buttonList", items);
                }                
            } else {
                alert("Failed : " + JSON.stringify(response.getError()));
            }
        }); 
        
        $A.enqueueAction(action);
    },
    
    // Assign Topic to Account - On Click
    assignTopic: function(component, event, helper, currentRecordId, labelName, isModel){
        var action = component.get("c.assignTopic");
        action.setParams({
            name: labelName,
            recordId: currentRecordId
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var topicId = response.getReturnValue().TopicId;
                var topicName = labelName;
                var mTopicName = "m_"+labelName;
                var expense = component.get("v.buttonList");                
                if(isModel == "model"){
                    component.find(mTopicName).destroy();
                }else{
                    component.find(topicName).destroy(); 
                }
                if(expense.includes(mTopicName) && isModel != "nonmodel"){
                    component.find(topicName).destroy(); 
                }
                
                this.createComponent(component, event, helper, topicId, labelName, isModel);
                this.getCount(component, event, helper, currentRecordId);
                this.getAccountName(component, event, helper, labelName, currentRecordId);                
                $A.get("e.force:closeQuickAction").fire();
            } else {
                alert("Failed : " + JSON.stringify(response.getError()));
            }
        });
        
        $A.enqueueAction(action);
    },
    
    // Get Assigned Topic to Account - On Page Load
    getAssignedTopic: function(component, event, helper, currentRecordId){
        var action = component.get("c.getTopic");
        action.setParams({
            recordId: currentRecordId
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {    
                var getValues = response.getReturnValue();
                var tagCountLabel = 'Tag ('+getValues.length+')';
                component.set("v.tagCount", tagCountLabel);
                for (var i = 0; i < getValues.length; i++) {
                    var topicId = getValues[i].Topic.Id;
                    var topicName = getValues[i].Topic.Name;
                    this.createComponent(component, event, helper, topicId, topicName);
                }
            } else {
                alert("Failed : " + JSON.stringify(response.getError()));
            }
        }); 
        
        $A.enqueueAction(action);
    },
    
    // Create Component - Lightning Pill
    createComponent: function(component, event, helper, topicId, topicName, isModel) {
        $A.createComponent(
            "lightning:pill",
            {
                "aura:id": topicName,
                "label": topicName,
                "class": "pillstyle",
                "href": "/lightning/r/Topic/"+topicId+"/view",
                "onremove": component.getReference("c.handleRemove")
            },
            function(buttonComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var outerDiv = component.find("lg-pill").get("v.body");
                    outerDiv.push(buttonComponent);
                    component.find("lg-pill").set("v.body", outerDiv);
                }
            }
        );
    },
    
    // Create Component - Lightning Button
    createComponentButton: function(component, event, helper, topicId, topicName, isModel) {
        $A.createComponent(
            "lightning:button",
            {
                "aura:id": isModel == "nonmodel" ? topicName : "m_"+topicName,
                "label": topicName,
                "title": topicName + "action",
                "class": "lgbuttonstyle",
                "onclick": isModel == "nonmodel" ? component.getReference("c.handleClick") : component.getReference("c.handleModelClick")
            },
            function(buttonComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    if (isModel == "nonmodel"){
                        var outerDiv = component.find("lg-button").get("v.body");
                        //outerDiv.push(buttonComponent);
                        component.find("lg-button").set("v.body", outerDiv);
                    }else{
                       if(topicName == 'SAP S/4HANA' || topicName == 'SAP BTP HANA' || topicName == 'SAP Cloud'
                           || topicName == 'SAP Analytics' || topicName == 'MACS' || topicName == 'GeoShield' || topicName == 'Geocoder'
                           || topicName == 'Unity Engine' || topicName == 'Utilities Apps' || topicName == 'Geospatial' || topicName == 'SAP Sell'){
                            var outerDiv = component.find("lg-model-potential").get("v.body");
                            outerDiv.push(buttonComponent);
                            component.find("lg-model-potential").set("v.body", outerDiv);
                        }else if( topicName == 'ArcGIS' || topicName == 'Salesforce' || topicName == 'SAP' || topicName == 'MS Azure'){
                            var outerDiv = component.find("lg-model-tech").get("v.body");
                            outerDiv.push(buttonComponent);
                            component.find("lg-model-tech").set("v.body", outerDiv);
                        }else if(topicName == 'Utilities' || topicName == 'Water' || topicName == 'Energy' || topicName == 'Public Safety'
                                 || topicName == 'SLG' || topicName == 'Healthcare' || topicName == 'Manufacturing' || topicName == 'High Tech'
                                 || topicName == 'Education' || topicName == 'Retail' || topicName == 'Transportation' || topicName == 'Logistic' || topicName == 'Telecommunication' || topicName == 'Oil & Gas'){
                            var outerDiv = component.find("lg-model-industry").get("v.body");
                            outerDiv.push(buttonComponent);
                            component.find("lg-model-industry").set("v.body", outerDiv);
                        }else{
                            var outerDiv = component.find("lg-model-others").get("v.body");
                            outerDiv.push(buttonComponent);
                            component.find("lg-model-others").set("v.body", outerDiv);
                        }                        
                    }                                         
                }
            }
        );
    },
    
    // Create Component - Lightning More Button
    createComponentMoreButton: function(component, event, helper) {
        $A.createComponent(
            "lightning:button",
            {
                "aura:id": "More",
                "label": "Tag Your Account",
                "title": "More action",
                "class": "lgbuttonstyle1",
                "variant": "brand",
                "onclick": component.getReference("c.handleMoreClick")
            },
            function(buttonComponent, status, errorMessage) {
                if (status === "SUCCESS") {
                    var outerDiv = component.find("lg-button").get("v.body");
                    outerDiv.push(buttonComponent);
                    component.find("lg-button").set("v.body", outerDiv);                  
                }
            }
        );
    },
    
    // Destroy Component - Lightning Pill    
    deleteTopic: function(component, event, helper, topicId, topicName) {
        var action = component.get("c.deleteTopic");        
        action.setParams({
            name: topicName,
            recordId: topicId
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState(); 
            if (state === "SUCCESS") {
                component.find("More").destroy(); 
                component.find(topicName).destroy();
                var topicId = response.getReturnValue().EntityId;                
                this.getCount(component, event, helper, topicId);
                this.createComponentButton(component, event, helper, topicId, topicName, "nonmodel");
                this.createComponentMoreButton(component, event, helper);
            } else {
                alert("Failed : " + JSON.stringify(response.getError()));
            }            
        });
        $A.enqueueAction(action);
    },
    
    // Get Topic Count 
    getCount: function(component, event, helper, topicId) {
        var action = component.get("c.getTopicCount");
        action.setParams({
            recordId: topicId
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {   
                var getValues = response.getReturnValue();
                var tagCountLabel = 'Tag ('+getValues.length+')';
                component.set("v.tagCount", tagCountLabel);
            } else {
                alert("Failed : " + JSON.stringify(response.getError()));
            }
        });
        
        $A.enqueueAction(action);
    }
});