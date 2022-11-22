@isTest
public class accountPlanControllerTest {
   /* @isTest
    public static void getAccountPlanNameTest(){
        Account acc=new Account();
        acc.Name = 'test';
        acc.CurrencyIsoCode = 'INR';
        acc.Industry = 'Technology';
        insert acc;
        Test.startTest();
        accountPlanController.getAccountPlanName(acc.id);
        Test.stopTest();
    }
    @isTest
    public static void addAccountPlanTest(){ 
        Account acc=new Account();
        acc.Name = 'test';
        acc.CurrencyIsoCode = 'INR';
        acc.Industry = 'Technology';
        insert acc;
        
        Account_Plans__c addPlan = new Account_Plans__c();
        addPlan.Account_Name__c =acc.Id ; 
        addPlan.Name = 'planName'; 
        addPlan.Potential_Revenue__c = 10;
        //addPlan.Client_Organization_Towers__c = 'organizationTowers';
        addPlan.Our_Revenue_Targets__c = 200;
        addPlan.Our_Business_Goals_Projects_we_want_to__c = 'businessGoals';
        //addPlan.Key_Business_Priorities_of_Client__c = 'keyBusiness';
        //addPlan.Major_Events__c = 'events';
        //addPlan.Client_IT_Landscape__c = 'clientLandscape';
        insert addPlan;
        
        Test.startTest();
        accountPlanController.addAccountPlan( addPlan.Account_Name__c,
                                             addPlan.Name,
                                             32,
                                             //addPlan.Client_Organization_Towers__c,
                                             300,
                                             addPlan.Our_Business_Goals_Projects_we_want_to__c);
                                             //addPlan.Key_Business_Priorities_of_Client__c,
                                             //addPlan.Major_Events__c,
                                             //addPlan.Client_IT_Landscape__c
        Test.stopTest();
    }
    @isTest
    public static void updateAccountPlanTest(){ 
        Account acc=new Account();
        acc.Name = 'test';
        acc.CurrencyIsoCode = 'INR';
        acc.Industry = 'Technology';
        insert acc;
        Account_Plans__c addPlan = new Account_Plans__c();
        addPlan.Account_Name__c =acc.Id ; 
        addPlan.Name = 'planName'; 
        addPlan.Potential_Revenue__c = 500;
        //addPlan.Client_Organization_Towers__c = 'organizationTowers';
        addPlan.Our_Revenue_Targets__c = 200;
        addPlan.Our_Business_Goals_Projects_we_want_to__c = 'businessGoals';
        //addPlan.Key_Business_Priorities_of_Client__c = 'keyBusiness';
        //addPlan.Major_Events__c = 'events';
        //addPlan.Client_IT_Landscape__c = 'clientLandscape';
        insert addPlan;
        Test.startTest();
        accountPlanController.updateAccountPlan( addPlan.Account_Name__c,
                                                addPlan.Name,
                                                32,
                                                //addPlan.Client_Organization_Towers__c,
                                                300,
                                                addPlan.Our_Business_Goals_Projects_we_want_to__c);
                                                //addPlan.Key_Business_Priorities_of_Client__c,
                                                //addPlan.Major_Events__c,
                                                //addPlan.Client_IT_Landscape__c
                                               
        Test.stopTest();
    }*/
}