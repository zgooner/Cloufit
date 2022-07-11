public class EventSpeakerTriggerHelper {
	public EventSpeakerTriggerHelper() {
        System.debug('Inside AccountTriggerHelper Constructor');
    }
	
    public void checkDuplicatedBookings(List<EventSpeakers__c> newEventSpeakers) {
		Set<Id> speakersIds = new Set<Id>();
        Set<Id> eventIds = new Set<Id>();
        for (EventSpeakers__c es : newEventSpeakers) {
            speakersIds.add(es.Speaker__c);
            eventIds.add(es.Event__c);
        }
        List<EventSpeakers__c> queriedES = [SELECT Id, Speaker__c, Event__r.End_Date_Time__c, Event__r.Start_DateTime__c FROM EventSpeakers__c WHERE Speaker__c IN :speakersIds];
        Map<Id, Speaker__c> speakersQueried = new Map<Id, Speaker__c>([SELECT Id FROM Speaker__c WHERE Id IN :speakersIds]);
        Map<Id, Event__c> eventsQueried = new Map<Id,Event__c>([SELECT Id, End_Date_Time__c, Start_DateTime__c FROM Event__c WHERE Id IN :eventIds]);
        Map<Speaker__c, List<Event__c>> speakersListForEvents = new Map<Speaker__c, List<Event__c>>();
        
        for(EventSpeakers__c es : queriedES) {
            List<Event__c> listOfEvents;
            if (speakersListForEvents.containsKey(speakersQueried.get(es.Speaker__c))) {
                listOfEvents = speakersListForEvents.get(speakersQueried.get(es.Speaker__c));
            } else {
                listOfEvents = new List<Event__c>();
            }
            
            listOfEvents.add(eventsQueried.get(es.Event__c));
            speakersListForEvents.put(speakersQueried.get(es.Speaker__c), listOfEvents);
        }
        
        for(EventSpeakers__c es : newEventSpeakers) {
            Event__c partEvent = eventsQueried.get(es.Event__c);
            List<Event__c> eventsToCompare = speakersListForEvents.get(speakersQueried.get(es.Speaker__c));
            for (Event__c event : eventsToCompare) {
                if (event.Start_DateTime__c <= partEvent.Start_DateTime__c 
                        && event.End_Date_Time__c >= partEvent.End_Date_Time__c) es.addError('Bookings are duplicated');
            }
        }
    }
}