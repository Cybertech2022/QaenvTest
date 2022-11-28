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
    // Add Account Plan
    addPlan: function(component, event, helper, currentRecordId) {
        var accountPlanName = component.find("accountPlanNameInputId").get('v.value');
        var potentialRevenue = component.find("potentialRevenueInputId").get('v.value') === '' ? parseInt("0") : component.find("potentialRevenueInputId").get('v.value');
        var clientOrganizationTowers = component.find("clientOrganizationTowersInputId").get('v.value');
        var ourRevenueTargets = component.find("ourRevenueTargetsInputId").get('v.value') === '' ? parseInt("0") : component.find("ourRevenueTargetsInputId").get('v.value');
        var ourBusinessGoalsProjects = component.find("ourBusinessGoalsProjectsInputId").get('v.value');
        var keyBusinessPriorities = component.find("keyBusinessPrioritiesInputId").get('v.value');
        var majorEvents = component.find("majorEventsInputId").get('v.value');
        var clientITLandscape = component.find("clientITLandscapeInputId").get('v.value');

        var action = component.get("c.addAccountPlan");
        
        action.setParams({
            recordId: currentRecordId,
            planName: accountPlanName,
            revenue: potentialRevenue,
            organizationTowers: clientOrganizationTowers,
            revenueTargets: ourRevenueTargets,
            businessGoals: ourBusinessGoalsProjects,
            keyBusiness: keyBusinessPriorities,
            events: majorEvents,
            clientLandscape: clientITLandscape,
        });
        
         action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var getValues = response.getReturnValue();
                this.showToast(
                    "Success !",
                    "Plan had been added successfully.",
                    "success"
                ); 
                window.location.reload()
            }else {
                this.showToast(
                    "Error !",
                    "Plan had not been added.",
                    "error"
                );
            }
        });        
            
        $A.enqueueAction(action);
    },
    // Update Account Plan
    updatePlan: function(component, event, helper, currentRecordId) {    
        
        var accountPlanName = component.find("accountPlanNameEditInputId").get('v.value');
        var potentialRevenue = component.find("potentialRevenueEditInputId").get('v.value') === '' ? parseInt("0") : component.find("potentialRevenueEditInputId").get('v.value');
        var clientOrganizationTowers = component.find("clientOrganizationTowersEditInputId").get('v.value');
        var ourRevenueTargets = component.find("ourRevenueTargetsEditInputId").get('v.value') === '' ? parseInt("0") : component.find("ourRevenueTargetsEditInputId").get('v.value');
        var ourBusinessGoalsProjects = component.find("ourBusinessGoalsProjectsEditInputId").get('v.value');
        var keyBusinessPriorities = component.find("keyBusinessPrioritiesEditInputId").get('v.value');
        var majorEvents = component.find("majorEventsEditInputId").get('v.value');
        var clientITLandscape = component.find("clientITLandscapeEditInputId").get('v.value');
        
        var action = component.get("c.updateAccountPlan");
        
        action.setParams({
            recordId: currentRecordId,
            planName: accountPlanName,
            revenue: potentialRevenue,
            organizationTowers: clientOrganizationTowers,
            revenueTargets: ourRevenueTargets,
            businessGoals: ourBusinessGoalsProjects,
            keyBusiness: keyBusinessPriorities,
            events: majorEvents,
            clientLandscape: clientITLandscape,
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var getValues = response.getReturnValue();
                this.showToast(
                    "Success !",
                    "Plan had been updated successfully.",
                    "success"
                );
                window.location.reload()
            }else {
                this.showToast(
                    "Error !",
                    "Plan had not been updated.",
                    "error"
                );
                //alert("Failed : " + JSON.stringify(response.getError()));
            }
        });
        
        $A.enqueueAction(action);
    },
    
    // If Account Plan does not exist
    nonExistingPlanDetail: function(component, event, helper, accountName) {
        component.set("v.accountName", accountName);
        component.set("v.accountPlanName", accountName + " " + "Account Plan");
    },
    
    // If Account Plan does exist
    existingPlanDetail: function(component, event, helper, accountName, accountPlanDetails) {
        var planDetails = JSON.parse(accountPlanDetails); 
        var createdDate = new Date(planDetails.CreatedDate);
        var lastModifiedDate = new Date(planDetails.LastModifiedDate);
        
        component.find("accountNameEditInputId").set("v.value", accountName);
        component.find("accountPlanNameEditInputId").set("v.value", planDetails.Name);
        component.find("potentialRevenueEditInputId").set("v.value", planDetails.Potential_Revenue__c);
        component.find("clientOrganizationTowersEditInputId").set("v.value", planDetails.Client_Organization_Towers__c);
        component.find("ourRevenueTargetsEditInputId").set("v.value", planDetails.Our_Revenue_Targets__c);
        component.find("ourBusinessGoalsProjectsEditInputId").set("v.value", planDetails.Our_Business_Goals_Projects_we_want_to__c);
        component.find("keyBusinessPrioritiesEditInputId").set("v.value", planDetails.Key_Business_Priorities_of_Client__c);
        component.find("majorEventsEditInputId").set("v.value", planDetails.Major_Events__c);
        component.find("clientITLandscapeEditInputId").set("v.value", planDetails.Client_IT_Landscape__c);
        component.find("createdbyEditInputId").set("v.value", planDetails.CreatedBy.Name + ", " + createdDate.toLocaleString());
        component.find("lastModifiedEditInputId").set("v.value", planDetails.LastModifiedBy.Name + ", " + lastModifiedDate.toLocaleString());
    },
    
    // Get Account Plan Names
    getAccountPlanName: function(component, event, helper, currentRecordId) {
        var action = component.get("c.getAccountPlanName");
        action.setParams({
            recordId: currentRecordId
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var getValues = response.getReturnValue();
                var accountName = getValues[0].Name;
                var createdByName = getValues[0].CreatedBy.Name;
                var lastModifiedByName = getValues[0].LastModifiedBy.Name;
                if (getValues[0].hasOwnProperty("Account_Plans__r")) {
                    // Have a Account Plan
                    var createNewPlanButton = component.find("createNewPlan");
                    $A.util.toggleClass(createNewPlanButton, "slds-hide");                 
                    var planDetails = JSON.stringify(getValues[0].Account_Plans__r[0]);
                    this.existingPlanDetail(component, event, helper, accountName, planDetails);
                } else {
                    // Does not have a Account Plan                  
                    var editPlanButton = component.find("editPlan");
                    $A.util.toggleClass(editPlanButton, "slds-hide"); 
                    var editForm = component.find("editAccountPlanForm");
                    $A.util.toggleClass(editForm, "slds-hide");                     
                    this.nonExistingPlanDetail(component, event, helper, accountName);
                }
            } else {
                alert("Failed : " + JSON.stringify(response.getError()));
            }
        });
        
        $A.enqueueAction(action);
    }
});