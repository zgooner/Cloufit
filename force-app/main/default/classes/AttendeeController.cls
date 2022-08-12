public with sharing class AttendeeController {
    @AuraEnabled(cacheable=true)
    public static List<Attendee__c> getEventAttendees(String eventId) {
        //to query zwróci ci wszystkich attendees jakich masz na środowisku. trzeba to ograniczyć... spróbowałbym takiego query:
        // SELECT Id, Event__c, ... FROM Event_Attentee__c WHERE Event__c =: eventId
        // Naprawiono 12.08.2022

        List<Event_Attendee__c> evAtt = [SELECT Id, Event__c, Attendee__c FROM Event_Attendee__c WHERE Event__c =:eventId];
        Set<Id> evAttendeesIds = new Set<Id>();

        for (Event_Attendee__c evA : evAtt) {
            evAttendeesIds.add(evA.Attendee__c);
        }

        return [SELECT Id, Name, Email__c, Phone__c, Company_Name__c, Location__c, Status__c, Last_Event_Date__c FROM Attendee__c WHERE ID IN :evAttendeesIds];
    }
}
