public class AccountTeamTriggerHandler {
    
    public static void onAfterInsert(list<AccountTeamMember> accList){
        sendEmail(accList,'insert');
    }
    public static void onAfterUpdate(list<AccountTeamMember> accList){
        sendEmail(accList,'update');
    }
    
    public static void onAfterDelete(list<AccountTeamMember> accList){
        sendEmail(accList,'delete');
    }
    
    private static void sendEmail(list<AccountTeamMember> accList,string action){
        List<Id> accIds = new List<Id>();
        map<id, AccountTeamMember> mapAccountTeam = new map<id, AccountTeamMember>();
        for(AccountTeamMember accTeam : accList){
            accIds.add(accTeam.UserId);
            mapAccountTeam.put(accTeam.UserId,accTeam);
        }
        
        if(accIds.size() > 0){
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            for(user us : [select id, email, FirstName from user where id in :accIds]){
                
              Account accountDetail = [select id,name from account where id =:mapAccountTeam.get(us.id).AccountId ];
                // Step 1: Create a new Email
              Messaging.SingleEmailMessage mail = 
              new Messaging.SingleEmailMessage();
            
              // Step 2: Set list of people who should get the email
              List<String> sendTo = new List<String>();
              sendTo.add(us.Email);
              mail.setToAddresses(sendTo);
            
              // Step 3: Set who the email is sent from
              mail.setReplyTo('connect@cybertech.com');
              mail.setSenderDisplayName('CyberTech Team' );
            
              // (Optional) Set list of people who should be CC'ed
              List<String> ccTo = new List<String>();
              mail.setCcAddresses(ccTo);
                
              
        
              // Step 4. Set email contents - you can use variables!
              
              String body = 'Hi ' + us.FirstName + ', <br> <br>';
                if(action == 'delete'){
                    mail.setSubject('Salesforce: You have been removed to account team of '+ accountDetail.Name);
                    body += 'You have been removed as ' + mapAccountTeam.get(us.id).TeamMemberRole +  ' from the account team of '+ accountDetail.Name + '<br> <br>';

                }
                else if(action == 'insert' || action =='update'){
                	mail.setSubject('Salesforce: You have been added to account team of '+ accountDetail.Name);
                    body += 'You have been added as '+ mapAccountTeam.get(us.id).TeamMemberRole +  ' to the account team  of '+ accountDetail.Name + '<br> <br>';


                }                
              body += 'CyberTech Salesforce Team';
              mail.setHtmlBody(body);
            
              // Step 5. Add your email to the master list
              mails.add(mail);
            }
            // Step 6: Send all emails in the master list
  			Messaging.sendEmail(mails);
        }
        
    }
}