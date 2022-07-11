@isTest
public class TestDataFactory {
    public static List<Event_Organizer__c> createEventOrganizers(Integer numOrg) {
        List<Event_Organizer__c> eventOrganizers = new List<Event_Organizer__c>();
        for (Integer i=0; i < numOrg; i++) {
            Event_Organizer__c org = new Event_Organizer__c(Name='test' + i, Email__c='test' + i + '@cloufit.com', Phone__c=String.valueOf(i));
            eventOrganizers.add(org);
        }
		insert eventOrganizers;        
        return eventOrganizers;
    }
    
    public static List<Speaker__c> createSpeakers(Integer numSpeak) {
        List<Speaker__c> speakers = new List<Speaker__c>();
        for (Integer i=0; i < numSpeak; i++) {
            Speaker__c speaker = new Speaker__c(Name='test' + i, Email__c='test' + i + '@google.com');
            speakers.add(speaker);
        }
        insert speakers;
        return speakers;
    }
    
    public static List<Datetime> createDatesFromStrings(String[] dates) {
        List<Datetime> datetimes = new List<Datetime>();
        for (Integer i = 0; i < dates.size(); i++) {
            datetimes.add(Datetime.valueOf(dates[i]));
        }
        
        return datetimes;
    }
    
    public static List<Event__c> createEvents(String[] startDatesString, String[] endDatesString) {
        List<Event_Organizer__c> orgList = TestDataFactory.createEventOrganizers(startDatesString.size()); //dates size defines how much events will be created
        System.debug(orgList);
        List<Datetime> startDates = createDatesFromStrings(startDatesString);
        List<Datetime> endDates = createDatesFromStrings(endDatesString);
        List<Event__c> events = new List<Event__c>();
        
        for (Integer i = 0; i < startDatesString.size(); i++) {
            Event__c event = new Event__c(Event_Organizer__c=orgList[i].Id, Max_Seats__c=i+10, Start_DateTime__c=startDates[i], End_Date_Time__c=endDates[i], Live__c=true);
            events.add(event);
        }
        insert events;
        return events;
    }
    
    public static List<EventSpeakers__c> createEventSpeakers(List<Event__c> events, List<Speaker__c> speakers) {
        List<EventSpeakers__c> eSpeakers = new List<EventSpeakers__c>();
        for (Integer i = 0; i < events.size(); i++) {
            EventSpeakers__c es = new EventSpeakers__c(Name='test' + i, Event__c=events[i].Id, Speaker__c=speakers[i].Id);
        }
        insert eSpeakers;
        return eSpeakers;
    }
}