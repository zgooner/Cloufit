public class EventAttendeeTriggerHelper {
	
    public void sendEmailAfterRegistration(List<Event_Attendee__c> newEventAttendees) {
        EmailHandler.sendRegistrationEmails(newEventAttendees);
    }
}