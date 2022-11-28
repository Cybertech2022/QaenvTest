public class ContactTopic {

    @AuraEnabled
    public static List<Topic> getTopicName(String recordId, String model){
        List<Topic> topicName;
        if(model == 'nonmodel'){
            topicName = [SELECT Id, Name, (SELECT TopicId FROM TopicAssignments where EntityId =: recordId) FROM topic Limit 5];            
        }else{
            topicName = [SELECT Id, Name, (SELECT TopicId FROM TopicAssignments where EntityId =: recordId) FROM topic];            
        }
        return topicName;
    }
    
    @AuraEnabled
    public static List<Contact> getContactName(String name, String recordId){
        List <Contact> Contactname = [SELECT Id, Salutation, Name FROM Contact WHERE Id=:recordId];
        return Contactname;
    }
    
    @AuraEnabled
    public static TopicAssignment assignTopic(String name, String recordId){
        String topicId = [SELECT Id, Name FROM Topic WHERE Name=:name].Id;
        TopicAssignment topicAsgn = new TopicAssignment();
        topicAsgn.TopicId = topicId; 
        topicAsgn.EntityId = recordId;
        insert topicAsgn;
        return topicAsgn;
    }
    
    @AuraEnabled
    public static List<TopicAssignment> getTopic(String recordId){
        List<TopicAssignment> topicName = [SELECT TopicId, Topic.Name FROM TopicAssignment WHERE EntityId =: recordId];
        return topicName;
    }
      
  @AuraEnabled
        public static TopicAssignment deleteTopic (String name, String recordId){
        TopicAssignment topicId = [SELECT TopicId, EntityId FROM TopicAssignment WHERE EntityId =: recordId AND Topic.Name =: name];        
         System.debug('TopicAssignment'+topicId);

        delete topicId;      
        return topicId; 
       
    }
    
  @AuraEnabled
    public static List<TopicAssignment> getTopicCount(String recordId){
        List<TopicAssignment> count = [SELECT TopicId FROM TopicAssignment WHERE EntityId =: recordId];
        return count;
    }
}