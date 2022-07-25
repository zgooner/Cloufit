public with sharing class EventController {
    @AuraEnabled(cacheable=true)
    public static List<Event__c> getCurrentEvents() {
        Datetime current = System.now();
        return [SELECT Id, End_Date_Time__c, Name, Name__c, Start_DateTime__c, Location__r.Name, Event_Detail__c, 
                Event_Organizer__r.Name FROM Event__c WHERE Start_DateTime__c >= :current];

    }

    @AuraEnabled
    public static List<Event__c> getSpecifiedEvents(String eventId, String locationId, String selectedDateTime) {
        String query = 'SELECT Id, Name, Name__c, Event_Organizer__r.Name, Start_DateTime__c, Location__r.Name, Event_Detail__c  FROM Event__c ' +
                            'WHERE Id=:eventId AND Location__c=:locationId AND Start_DateTime__c>=:convertedDateTime';
        if (eventId == null) query = query.replace('Id=:eventId AND', '');
        if (locationId == null) {
            query = query.replace('AND Location__c=:locationId', '');
            query = query.replace('Location__c=:locationId AND', '');
            query = query.replace('Location__c=:locationId', '');
        }
        if(selectedDateTime == null) query = query.replace('AND Start_DateTime__c=:convertedDateTime', '');
        else {
            selectedDateTime = selectedDateTime.replace('T', ' ');
            selectedDateTime = selectedDateTime.replace('0Z', '');
            Datetime convertedDateTime = Datetime.valueOf(selectedDateTime);
        }

        if (eventId == null && locationId == null && selectedDateTime == null) return getCurrentEvents();
        return Database.query(query);
    }

    @AuraEnabled(cacheable=true)
    public static List<Event__c> getAttendeesUpcomingEvents(String attId) {
        List<Event_Attendee__c> evAtt = [SELECT Id, Event__c, Attendee__c FROM Event_Attendee__c WHERE Attendee__c=:attId];
        Set<Id> evIds = new Set<Id>();
        for (Event_Attendee__c evAt : evAtt) {
            evIds.add(evAt.Event__c);
        }

        return [SELECT Id, Name__c, Event_Organizer__r.Name, Start_DateTime__c, End_Date_Time__c, Location__r.Name 
                FROM Event__c 
                WHERE Id IN :evIds AND
                End_Date_Time__c >= :System.now()];

    }

    @AuraEnabled(cacheable=true)
    public static List<Event__c> getAttendeesPastEvents(String attId) {
        List<Event_Attendee__c> evAtt = [SELECT Id, Event__c, Attendee__c FROM Event_Attendee__c WHERE Attendee__c=:attId];
        Set<Id> evIds = new Set<Id>();
        for (Event_Attendee__c evAt : evAtt) {
            evIds.add(evAt.Event__c);
        }
        
        return [SELECT Id, Name__c, Event_Organizer__r.Name, Start_DateTime__c, End_Date_Time__c ,Location__r.Name 
                FROM Event__c 
                WHERE Id IN :evIds AND
                End_Date_Time__c < :System.now()];
        
    }
}
