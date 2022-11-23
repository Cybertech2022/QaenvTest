trigger UpdateAccountTrigger on Account(before insert, after update) {
    if (!Trigger.isInsert) {
        Account NewAccount = trigger.new[0];
        Account OldAccount = trigger.old[0];
        Account AccountObj = new Account();
        String [] arrayOfUpdatedFeilds = new List<String>();
        String [] arrayOfNewValue = new List<String>();
        String [] arrayOfPreviousValue = new List<String>(); 
        Schema.SObjectType objType = AccountObj.getSObjectType();
        Map < String, Schema.SObjectField > M = Schema.SObjectType.Account.fields.getMap();
        for (String str: M.keySet()) {
            try {
                if (NewAccount.get(str) != OldAccount.get(str)) {
                    List < Account > accList = new List < Account > ();
                    for (Account a: Trigger.new) {
                        Account accUpdate = new Account(Id = a.Id);
                        if (str != 'updatedfield__c' && str != 'previous_value__c' && str != 'new_value__c' && str != 'systemmodstamp' && str != 'lastmodifieddate') {
                            System.debug('Field name: ' + str + '. New value: ' + NewAccount.get(str) + '. Old value: ' + OldAccount.get(str));
                            string newValue = String.valueOf(NewAccount.get(str));
                            string oldValue = String.valueOf(OldAccount.get(str));
                            arrayOfUpdatedFeilds.add(str);
                            arrayOfNewValue.add(newValue);
                            arrayOfPreviousValue.add(oldValue);
                            accUpdate.UpdatedField__c = String.valueOf(arrayOfUpdatedFeilds);
                            accUpdate.New_Value__c = String.valueOf(arrayOfNewValue);                                                                           
                            accUpdate.Previous_Value__c = String.valueOf(arrayOfPreviousValue);
                        }
                        accList.add(accUpdate);
                    }
                    update accList;
                }
            } catch (Exception e) {
                System.debug('Error: ' + e);
            }
        }
    }
}