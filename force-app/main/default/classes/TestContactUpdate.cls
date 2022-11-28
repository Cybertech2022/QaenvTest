@IsTest
public class TestContactUpdate {
	private static testMethod void myUnitTest() {
        Account acc = new Account(Name = 'Test Account', CurrencyIsoCode = 'USD', Industry = 'Healthcare');
		insert acc;        
        acc = [SELECT Id, Name, CurrencyIsoCode, Industry FROM Account WHERE Id =: acc.Id];
        
		Contact cont = new Contact(lastname = 'Test Contact', AccountId = acc.Id, CurrencyIsoCode = 'USD');
		insert cont;

        cont.CurrencyIsoCode = 'INR';
		update cont;
        
		cont = [SELECT Id, lastname, AccountId, CurrencyIsoCode FROM Contact WHERE Id =: cont.Id];
		System.assertEquals('INR', cont.CurrencyIsoCode);
        
		update cont;
	}
}