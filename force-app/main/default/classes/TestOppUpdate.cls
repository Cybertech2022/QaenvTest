@IsTest
public class TestOppUpdate {
    private static testMethod void myUnitTest() {
        Account acc = new Account(Name = 'Test Account', CurrencyIsoCode = 'USD', Industry = 'Healthcare');
        insert acc;        
        acc = [SELECT Id, Name, CurrencyIsoCode, Industry FROM Account WHERE Id =: acc.Id];
        
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', AccountId = acc.Id, Type = 'New Business', CyberTech_Solution__c = 'EMCS', StageName = 'Discovery with SE', CloseDate = Date.today(), CurrencyIsoCode = 'USD');
        insert opp;

        opp.Type = 'Existing Business';
        update opp;
        
        opp = [SELECT Id, name, Type, CyberTech_Solution__c, StageName, CloseDate, CurrencyIsoCode FROM Opportunity WHERE Id =: opp.Id];
        System.assertEquals('Existing Business', opp.Type);
        
        update opp;
    }
}