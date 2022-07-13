public class EmailHandler {
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
        	msg.setTargetObjectId('0057Q000004fKtc');
        	msg.setReplyTo('noreply@cloufit.com');
       		msg.setUseSignature(false);
   			msg.setBccSender(false);
   			msg.setSaveAsActivity(false);
            
        	msg.setTemplateId(template.Id);
        	//msg.setWhatId(c.Id);
        	msg.toAddresses = new String[] {c.Attendee__r.Email__c};
            messages.add(msg);
        }
       
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        for(Messaging.SendEmailResult result : results) {
            if (!result.success) {
                System.debug('The email failed to send:'  + result.getErrors());
            }
        }

    }
}