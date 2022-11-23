trigger AccountTeamTrigger on AccountTeamMember (after insert, after update, before delete) {
    
    //if(Utility.isTriggerEnabled('AccountTeamTrigger') == false) return;
    
    //after insert
    if(trigger.isAfter && trigger.isInsert){
        system.debug('yes');
       AccountTeamTriggerHandler.onAfterInsert(trigger.new);
    }
    
    //after update
    if(trigger.isAfter && trigger.isUpdate){
       AccountTeamTriggerHandler.onAfterUpdate(trigger.new);
    }  
    
    //after delete
    if(trigger.isBefore && trigger.isDelete){
      AccountTeamTriggerHandler.onAfterDelete(Trigger.old);
    }
    
}