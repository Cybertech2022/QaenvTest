public class accountPlanController {
	@AuraEnabled
    public static List<Account> getAccountPlanName(String recordId){
        List<Account> planName = [SELECT Id, CreatedBy.Name, LastModifiedBy.Name, Name,(SELECT Id, Account_Name__c, Name, Potential_Revenue__c, 
                                                    Client_Organization_Towers__c, Our_Revenue_Targets__c, 
                                                    Key_Business_Priorities_of_Client__c,Our_Business_Goals_Projects_we_want_to__c,                                                   
                                                    Major_Events__c, 
                                                    Client_IT_Landscape__c, CreatedBy.Name, CreatedDate, 
                                                    LastModifiedBy.Name, LastModifiedDate
                                                    FROM Account_Plans__r) FROM Account WHERE Id =: recordId];   
        return planName;
    }
    
    @AuraEnabled
    public static Account_Plans__c addAccountPlan(String recordId, String planName, Double revenue,  String organizationTowers, 
                                                  Double revenueTargets, String businessGoals, String keyBusiness, 
                                                  String events,  
                                                   String clientLandscape){
        Account_Plans__c addPlan = new Account_Plans__c();
        addPlan.Account_Name__c = recordId; 
        addPlan.Name = planName; 
        addPlan.Potential_Revenue__c = revenue;
        addPlan.Client_Organization_Towers__c = organizationTowers;
        addPlan.Our_Revenue_Targets__c = revenueTargets;
        addPlan.Our_Business_Goals_Projects_we_want_to__c = businessGoals;
        addPlan.Key_Business_Priorities_of_Client__c = keyBusiness;
        addPlan.Major_Events__c = events;
        addPlan.Client_IT_Landscape__c = clientLandscape;
        insert addPlan;
        return addPlan;
    }
        
    @AuraEnabled
    public static Account_Plans__c updateAccountPlan(String recordId, String planName, Double revenue,  String organizationTowers, 
                                                  Double revenueTargets, String businessGoals, String keyBusiness, 
                                                  String events,  
                                                   String clientLandscape){
        Account_Plans__c updatePlan = [SELECT Name, Potential_Revenue__c,  Client_Organization_Towers__c,
                                       Our_Revenue_Targets__c, Our_Business_Goals_Projects_we_want_to__c, 
                                       Key_Business_Priorities_of_Client__c, Major_Events__c,
                                       Client_IT_Landscape__c
                                       FROM Account_Plans__c WHERE Account_Name__c =: recordId];
        updatePlan.Account_Name__c = recordId; 
        updatePlan.Name = planName; 
        updatePlan.Potential_Revenue__c = revenue;
        updatePlan.Client_Organization_Towers__c = organizationTowers;
        updatePlan.Our_Revenue_Targets__c = revenueTargets;
        updatePlan.Our_Business_Goals_Projects_we_want_to__c = businessGoals;
        updatePlan.Key_Business_Priorities_of_Client__c = keyBusiness;
        updatePlan.Major_Events__c = events;
        updatePlan.Client_IT_Landscape__c = clientLandscape;
        update  updatePlan;
        return updatePlan;
    }   
}

//commit line 