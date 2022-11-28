trigger UpdateOppTrigger on Opportunity (before insert, after update) {
    if (!Trigger.isInsert) {
     	Opportunity NewOpportunity = trigger.new[0];
        Opportunity OldOpportunity = trigger.old[0];
        Opportunity OpportunityObj = new Opportunity();
        String [] arrayOfUpdatedFeilds = new List<String>();
        String [] arrayOfNewValue = new List<String>();
        String [] arrayOfPreviousValue = new List<String>(); 
        Schema.SObjectType objType = OpportunityObj.getSObjectType();
        Map < String, Schema.SObjectField > M = Schema.SObjectType.Opportunity.fields.getMap();        
        for (String str: M.keySet()) {
            try {
                if (NewOpportunity.get(str) != OldOpportunity.get(str)) {
                    List < Opportunity > oppList = new List < Opportunity > ();                    
                    for (Opportunity o: Trigger.new) {
                        Opportunity oppUpdate = new Opportunity(Id = o.Id);
                        if (str != 'updatedfield__c' && str != 'previous_value__c' && str != 'new_value__c' && str != 'systemmodstamp' && str != 'lastmodifieddate' && str != 'LastModifiedById') {
                            System.debug('Field name: ' + str + '.New value: ' + NewOpportunity.get(str) + '. Old value: ' + OldOpportunity.get(str));                            
                            string newValue;
                            string oldValue;
                            string feildUpdated;
                            if(str != 'probability' && str != 'lastclosedatechangedhistoryid'){
                                arrayOfUpdatedFeilds.add(str);
                                arrayOfNewValue.add(String.valueOf(NewOpportunity.get(str)));
                                arrayOfPreviousValue.add(String.valueOf(OldOpportunity.get(str)));
                            }
                            oppUpdate.UpdatedField__c = String.valueOf(arrayOfUpdatedFeilds);
							oppUpdate.New_Value__c = String.valueOf(arrayOfNewValue);                                                                           
                            oppUpdate.Previous_Value__c = String.valueOf(arrayOfPreviousValue);
                        }
                        oppList.add(oppUpdate);
                    }
                    update oppList;
                }
            } catch (Exception e) {
                System.debug('Error: ' + e);
            }
        }   
    }
}