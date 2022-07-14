public class EmailHandler {
    private static final String userID = '0057Q000004fKtc';
    private static final String noreplyEmail = 'noreply@cloufit.com';
    
    public static void sendRegistrationEmails(List<Event_Attendee__c> attendees) {
        EmailTemplate template = [SELECT Id, Subject, Description, HtmlValue, DeveloperName, Body FROM EmailTemplate
                                  WHERE name='RegisterTemplate'];
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();
        
        Set<Id> attendeeIds = new Set<Id>();
        for (Event_Attendee__c c : attendees) {
            attendeeIds.add(c.Attendee__c);
        }
        
        List<Event_Attendee__c> evAttendees = [SELECT Id, Attendee__r.Email__c, Event__c FROM Event_Attendee__c WHERE Attendee__c IN :attendeeIds];
        
        for (Event_Attendee__c c : evAttendees) {
            Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        	msg.setTargetObjectId(userID);
        	msg.setReplyTo(noreplyEmail);
       		msg.setUseSignature(false);
   			msg.setBccSender(false);
   			msg.setSaveAsActivity(false);
            
        	msg.setTemplateId(template.Id);
        	//msg.setWhatId(c.Id);
        	msg.toAddresses = new String[] {c.Attendee__r.Email__c};
            messages.add(msg);
        }
       
        checkMailErrors(Messaging.sendEmail(messages));

    }
    
    public static void sendSimpleMessage(String address, String simpleBody) {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setReplyTo(noreplyEmail);
        message.setUseSignature(false);
   		message.setBccSender(false);
   		message.setSaveAsActivity(true);
        message.toaddresses = new String[] {address};
        message.setPlainTextBody(simpleBody);
        
        Messaging.SingleEmailMessage[] listOfMail = new List<Messaging.SingleEmailMessage> {message};
        
        checkMailErrors(Messaging.sendEmail(listOfMail));  
    }
    
    private static void checkMailErrors(Messaging.SendEmailResult[] results) {
       for(Messaging.SendEmailResult result : results) {
            if (!result.success) {
                System.debug('The email failed to send:'  + result.getErrors());
            }
        } 
    }
}