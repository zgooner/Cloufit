public with sharing class AttendeeController {
    @AuraEnabled(cacheable=true)
    public static List<Attendee__c> getEventAttendees(String eventId) {
        return [SELECT Id, Name, Email__c, Phone__c, Company_Name__c, Location__c, Status__c, Last_Event_Date__c, 
                (SELECT Id FROM Event_Attendees__r WHERE Event__c=:eventId) FROM Attendee__c];
    }
}
