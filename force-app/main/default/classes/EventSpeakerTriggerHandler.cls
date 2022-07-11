public without sharing class EventSpeakerTriggerHandler implements TriggerHandler {
	private boolean triggerIsExecuting;
    private Integer triggerSize;
    public EventSpeakerTriggerHelper helper;
    public EventSpeakerTriggerHandler(boolean triggerIsExecuting, Integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new EventSpeakerTriggerHelper();
    }
    
    public void beforeInsert(List<EventSpeakers__c> newEventSpeakers) {
		helper.checkDuplicatedBookings(newEventSpeakers);
    }
    public void beforeUpdate(List<EventSpeakers__c> oldEventSpeakers, List<EventSpeakers__c> newEventSpeakers, Map<ID, SObject> oldEventSpeakersMap, Map<ID, SObject> newEventSpeakersMap) {
		helper.checkDuplicatedBookings(newEventSpeakers);
    }
    public void beforeDelete(List<EventSpeakers__c> oldEventSpeakers, Map<ID, SObject> oldEventSpeakersMap) {

    }
    public void afterInsert(List<EventSpeakers__c> newEventSpeakers, Map<ID, SObject> newEventSpeakersMap) {

    }
    public void afterUpdate(List<EventSpeakers__c> oldEventSpeakers, List<EventSpeakers__c> newEventSpeakers, Map<ID, SObject> oldEventSpeakersMap, Map<ID, SObject> newEventSpeakersMap) {

    }
    public void afterDelete(List<EventSpeakers__c> oldEventSpeakers, Map<ID, SObject> oldEventSpeakersMap) {

    }
    public void afterUndelete(List<EventSpeakers__c> newEventSpeakers, Map<ID, SObject> newEventSpeakersMap) {

    }
}