public with sharing class AttendeeController {
    @AuraEnabled(cacheable=true)
    public static List<Attendee__c> getEventAttendees(String eventId) {
        //to query zwróci ci wszystkich attendees jakich masz na środowisku. trzeba to ograniczyć... spróbowałbym takiego query:
        // SELECT Id, Event__c, ... FROM Event_Attentee__c WHERE Event__c =: eventId
        List<Attendee__c> attendees = [SELECT Id, Name, Email__c, Phone__c, Company_Name__c, Location__c, Status__c, Last_Event_Date__c, (SELECT Id, Event__c FROM Event_Attendees__r WHERE Event__c =:eventId) FROM Attendee__c];
        List<Attendee__c> evAttendees = new List<Attendee__c>();
        for (Attendee__c att : attendees) {
            if (!att.Event_Attendees__r.isEmpty()) evAttendees.add(att);
        }

        return evAttendees;
    }
}
