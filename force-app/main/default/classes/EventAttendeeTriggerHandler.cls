public class EventAttendeeTriggerHandler implements TriggerHandler {
	private boolean triggerIsExecuting;
    private Integer triggerSize;
    public EventAttendeeTriggerHelper helper;
    public EventAttendeeTriggerHandler(boolean triggerIsExecuting, Integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new EventAttendeeTriggerHelper();
    }
    
    public void beforeInsert(List<Event_Attendee__c> newEventAttendees) {
		
    }
    public void beforeUpdate(List<Event_Attendee__c> oldEventAttendees, List<Event_Attendee__c> newEventAttendees, Map<ID, SObject> oldEventAttendeesMap, Map<ID, SObject> newEventAttendeesMap) {

    }
    public void beforeDelete(List<Event_Attendee__c> oldEventAttendees, Map<ID, SObject> oldEventAttendeesMap) {
        
    }
    public void afterInsert(List<Event_Attendee__c> newEventAttendees, Map<ID, SObject> newEventAttendeesMap) {
		helper.sendEmailAfterRegistration(newEventAttendees);
    }
    public void afterUpdate(List<Event_Attendee__c> oldEventAttendees, List<Event_Attendee__c> newEventAttendees, Map<ID, SObject> oldEventAttendeesMap, Map<ID, SObject> newEventAttendeesMap) {

    }
    public void afterDelete(List<Event_Attendee__c> oldEventAttendees, Map<ID, SObject> oldEventAttendeesMap) {
        
    }
    public void afterUndelete(List<Event_Attendee__c> newEventAttendees, Map<ID, SObject> newEventAttendeesMap) {
        
    }
}