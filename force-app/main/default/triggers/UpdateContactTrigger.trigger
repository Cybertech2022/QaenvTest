trigger UpdateContactTrigger on Contact(before insert, after update) {
    if (!Trigger.isInsert) {
     	Contact NewContact = trigger.new[0];
        Contact OldContact = trigger.old[0];
        Contact ContactObj = new Contact();
        String [] arrayOfUpdatedFeilds = new List<String>();
        String [] arrayOfNewValue = new List<String>();
        String [] arrayOfPreviousValue = new List<String>(); 
        Schema.SObjectType objType = ContactObj.getSObjectType();
        Map < String, Schema.SObjectField > M = Schema.SObjectType.Contact.fields.getMap();
        for (String str: M.keySet()) {
            try {
                if (NewContact.get(str) != OldContact.get(str)) {
                    List < Contact > contactList = new List < Contact > ();					                      
                    for (Contact c: Trigger.new) {
                        Contact contactUpdate = new Contact(Id = c.Id);	                        
                        if (str != 'updatedfield__c' && str != 'previous_value__c' && str != 'new_value__c' && str != 'systemmodstamp' && str != 'lastmodifieddate') {
                            System.debug('Field name: ' + str + '. New value: ' + NewContact.get(str) + '. Old value: ' + OldContact.get(str));
                            string newValue = String.valueOf(NewContact.get(str));
                            string oldValue = String.valueOf(OldContact.get(str));
                            arrayOfUpdatedFeilds.add(str);
                            arrayOfNewValue.add(newValue);
                            arrayOfPreviousValue.add(oldValue);
                            contactUpdate.UpdatedField__c = String.valueOf(arrayOfUpdatedFeilds);
							contactUpdate.New_Value__c = String.valueOf(arrayOfNewValue); //newValue;                                                                                  
                            contactUpdate.Previous_Value__c = String.valueOf(arrayOfPreviousValue); //oldValue;
                        }    
                        contactList.add(contactUpdate);
                    }
                    update contactList;                                                     
                }
            } catch (Exception e) {
                System.debug('Error: ' + e);
            }
        }   
    }
}