/*************************************
 Name : AccountTriggerHandlerTest
 Created At : 10-10-2020
 Desc : Test Class for the AccountTriggerHandler
**************************************/

@isTest
private class AccountTriggerHandlerTest {
    @testsetup static void setup(){
        Account acc = new Account(Name = 'test', CurrencyIsoCode = 'INR' , Industry = 'Technology');
        insert acc;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        
          USer newUser = new User(lastname = 'Test',Alias = 'Test',TimeZoneSidKey = 'GMT',
            LocaleSidKey = 'eu_ES',EmailEncodingKey = 'ISO-8859-1',
            ProfileId = p.id,LanguageLocaleKey = 'en_US',
            userName='Test@sdkksdhfhdsjhf.com',email='Test@asjgdgsad.com');
        insert newUser;
        
        AccountTeamMember Acm = new AccountTeamMember(AccountId = acc.id , UserId = newUser.id,  TeamMemberRole = 'Account Manager' , AccountAccessLevel = 'Edit', CaseAccessLevel = 'Edit', OpportunityAccessLevel = 'Edit');
        insert Acm;
    }
    @isTest static void updateAccountTeamMember(){
        AccountTeamMember acm = [Select Id, TeamMemberRole From AccountTeamMember];
        acm.TeamMemberRole = 'Account Executive';
        
        Test.startTest();
       		update acm;
        AccountTeamMember acm1 = [Select Id, TeamMemberRole From AccountTeamMember];
        system.assertEquals('Account Executive', acm1.TeamMemberRole);
        Test.stopTest();
    }
    @isTest static void deleteAccountTeamMember(){
         AccountTeamMember acm = [Select Id, TeamMemberRole From AccountTeamMember];
        
        Test.startTest();
       		delete acm;
        Test.stopTest();
    }
}