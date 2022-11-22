({
    doInit : function(component, event, helper) {
      
        component.set("v.FieldEdit","");
        component.set("v.FieldEdit1","");
        component.set("v.FieldEdit2","");
        component.set("v.FieldEdit3","");
        component.set("v.FieldEdit4","");
         component.set("v.FieldEdit5","");
         component.set("v.FieldEdit6","");
         component.set("v.FieldEdit7","");
         component.set("v.FieldEdit8","");
         component.set("v.FieldEdit9","");







 var currentRecordId = component.get("v.recordId");
        // Get Account Plan Names
        helper.getAccountPlanName(component, event, helper, currentRecordId); 	
    },
    handleAddPlanClick: function(component, event, helper) {

        var currentRecordId = component.get("v.recordId");
        // Add Account Plan
        component.set("v.isModalOpen", false);

        helper.addPlan(component, event, helper, currentRecordId);   	
    },    
    handleEditClick: function(component, event, helper) {

        var currentRecordId = component.get("v.recordId");
        if(component.find("accountPlanNameEditInputId").get('v.value') == '' ){
            helper.showToast(
                "Error !",
                "Please enter the required fields.",
                "error"
            );
        }else{
            // Update Account Plan
            helper.updatePlan(component, event, helper, currentRecordId); 	
        }        
    },
    handleCreateNewPlanClick: function(component, event, helper) { 

        component.set("v.isModalOpen", true);        
    },
    handleCloseModalClick: function(component, event, helper) {

        component.set("v.isModalOpen", false);
    },
    
    handleKeyup : function(component, event, helper) {
    var elem = event.getSource().get('v.value');
    var max = 1000;
    var remaining = max - elem.length;

  component.set("v.FieldEdit", remaining + " " + "character remaining" );
    },

 
 // component.set("v.FieldEdit3", remaining + " " + "character remaining" );
 // component.set("v.FieldEdit4", remaining + " " + "character remaining" );
 handleKeyup1 : function(component, event, helper) {
    var elem = event.getSource().get('v.value');
    var max = 1000;
    var remaining = max - elem.length;
  component.set("v.FieldEdit1", remaining + " " + "character remaining" );

},
    
 handleKeyup2 : function(component, event, helper) {
    var elem = event.getSource().get('v.value');
    var max = 1000;
    var remaining = max - elem.length;
  component.set("v.FieldEdit2", remaining + " " + "character remaining" );
 },
    
     handleKeyup3 : function(component, event, helper) {
    var elem = event.getSource().get('v.value');
    var max = 1000;
    var remaining = max - elem.length;
  component.set("v.FieldEdit3", remaining + " " + "character remaining" );
 },
    
       handleKeyup4 : function(component, event, helper) {
    var elem = event.getSource().get('v.value');
    var max = 1000;
    var remaining = max - elem.length;
  component.set("v.FieldEdit4", remaining + " " + "character remaining" );
 },
    
         handleKeyup5 : function(component, event, helper) {
    var elem = event.getSource().get('v.value');
    var max = 1000;
    var remaining = max - elem.length;
  component.set("v.FieldEdit5", remaining + " " + "character remaining" );
 },
             handleKeyup6 : function(component, event, helper) {
    var elem = event.getSource().get('v.value');
    var max = 1000;
    var remaining = max - elem.length;
  component.set("v.FieldEdit6", remaining + " " + "character remaining" );
 },
                handleKeyup7 : function(component, event, helper) {
    var elem = event.getSource().get('v.value');
    var max = 1000;
    var remaining = max - elem.length;
  component.set("v.FieldEdit7", remaining + " " + "character remaining" );
 },
                handleKeyup8 : function(component, event, helper) {
    var elem = event.getSource().get('v.value');
    var max = 1000;
    var remaining = max - elem.length;
  component.set("v.FieldEdit8", remaining + " " + "character remaining" );
 },
                    handleKeyup9 : function(component, event, helper) {
    var elem = event.getSource().get('v.value');
    var max = 1000;
    var remaining = max - elem.length;
  component.set("v.FieldEdit9", remaining + " " + "character remaining" );
 },
})