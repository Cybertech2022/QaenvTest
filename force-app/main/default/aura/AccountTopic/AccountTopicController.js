({
    doInit: function(component, event, helper) {        
        var currentRecordId = component.get("v.recordId");
        // Get Tags Name
        helper.getTopicName(component, event, helper, currentRecordId, "nonmodel"); 
        // Get Tags Assigned
        helper.getAssignedTopic(component, event, helper, currentRecordId);
    },
    handleClick: function(component, event, helper) {
        var currentRecordId = component.get("v.recordId");
        var labelName = event.getSource().get("v.label");
        // On Click - Assigned Topic to Lead     
        helper.assignTopic(component, event, helper, currentRecordId, labelName, "nonmodel");          
    },
    handleModelClick: function(component, event, helper) {
        var currentRecordId = component.get("v.recordId");
        var labelName = event.getSource().get("v.label");        
        // On Click of Model Button - Assigned Topic to Lead
        helper.assignTopic(component, event, helper, currentRecordId, labelName, "model");    
    },
    handleRemove: function(component, event, helper) {
         var currentRecordId = component.get("v.recordId");
        
        component.set('v.templabel',event.getSource().get("v.label"));
        console.log(event.getSource().get("v.label"));
        // On Click - Remove Tag Assigned
        component.set('v.showConfirmDialog', true);
    },
    handleMoreClick: function(component, event, helper){
        var currentRecordId = component.get("v.recordId");   
        // Get Tags Name
        helper.getTopicName(component, event, helper, currentRecordId, "model"); 
        component.set("v.isOpen", true);
    },
    closeModel: function(component, event, helper){		        
        var currentRecordId = component.get("v.recordId");         
        component.set("v.isOpen", false);
    },
    
      handleConfirmDialogYes : function(component, event, helper) {
        var currentRecordId = component.get("v.recordId");
        var labelName = component.get("v.templabel");
        helper.deleteTopic(component, event, helper, currentRecordId, labelName);   
        component.set('v.showConfirmDialog', false);
        
    },
    handleConfirmDialogNo : function(component, event, helper) {
        console.log('No');
        component.set('v.showConfirmDialog', false);
    }
});