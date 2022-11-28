@IsTest
public class AccountTest{
    
    /*-----------------VARIABLES---------------------*/
    public static List<Topic> topics = new List<Topic>();                                                // This is to handle BULK Topic list
    public static list<TopicAssignment> topicassign = new List<TopicAssignment>();  // This is to handle BULK Topic Assgn list
    public static list<Lead> leads = new List<Lead>();
    public static Id entId;
    
    
    public static void createTestTopic() {
        
    }
    
    @isTest
    static void UseCase1(){
        Lead ld1 = new Lead();
        ld1.LastName = 'Sales Lead for today';
        ld1.Company = 'TomorrowLand';
        leads.add(ld1);
        // System.assertEquals(null, leads);
        insert leads;
        system.debug('LEAD--'+leads);
        entId = ld1.Id;
        
        Topic tp1 = new Topic();
        tp1.Name = 'TopicTest';
        topics.add(tp1);
        // System.assert(topics.isEmpty());
        system.debug('TOPICS--'+topics);
        insert topics;
        
        
        
        TopicAssignment topicAsgn = new TopicAssignment();
        topicAsgn.TopicId = tp1.Id; 
        topicAsgn.EntityId = entId;
        system.debug('TOPICS ASSGN--'+topicAsgn);
        insert topicAsgn;
        
        // Creating Class constructor
        
        AccountTopic crc = new AccountTopic();
        String recId = String.Valueof(entId);
        system.debug('REC --'+recId);
        Test.startTest();
        TopicAssignment tt= AccountTopic.assignTopic(topics[0].Name, recId );
        List<TopicAssignment>    t2 = AccountTopic.getTopic(recId);
        TopicAssignment t3 = AccountTopic.deleteTopic(topics[0].Name, recId);
        List<TopicAssignment> t4 = AccountTopic.getTopicCount(recId);
        AccountTopic.getTopicName(recId,'Test');
        // System.assertEquals(null, tt);
        Test.StopTest();
    }
    
}