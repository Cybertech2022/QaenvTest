@IsTest
public class AccountPlanTest1{    
    public static List<Account> accounts = new List<Account>();                                                // This is to handle BULK Topic list
    public static list<Account_Plans__c> accountplan = new List<Account_Plans__c>();  // This is to handle BULK Topic Assgn list
    public static Id entId;
        
    public static void createTestAccount() {        
    }
    
    @IsTest
    static void UseCase1(){
        Account acc1= new Account();
        acc1.Name='Triumph Group';
        acc1.BillingState='Mumbai';
        
        // System.assertEquals(null, leads);
        
        
        system.debug('ACCOUNT--'+accounts);
        insert accounts;
        
        Account_Plans__c ap1= new Account_Plans__c();
        ap1.Name='Pranav';
        ap1.Client_IT_Landscape__c='ABC';
        
        
        system.debug('ACCOUNTPLAN--'+accountplan);
        insert accountplan;

        // Creating Class constructor
        
        accountPlanController crc = new accountPlanController();
        String recordId = String.Valueof(accountplan);
        system.debug('REC --'+recordId);

        Test.startTest();
        Test.StopTest();
        }
}