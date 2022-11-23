@IsTest
public class TestAccountUpdate {
	private static testMethod void myUnitTest() {
		Account acc = new Account(Name = 'Test Account', CurrencyIsoCode = 'USD', Industry = 'Healthcare');
		insert acc;

        acc.Industry = 'Telecommunications';
		update acc;
        
		acc = [SELECT Id, Name, CurrencyIsoCode, Industry FROM Account WHERE Id =: acc.Id];
		System.assertEquals('Telecommunications', acc.Industry);
        
		update acc;
	}
}