public with sharing class EventController {
    @AuraEnabled(cacheable=true)
    public static List<Event__c> getCurrentEvents() {
        Datetime current = System.now();
        return [SELECT Id, End_Date_Time__c, Name, Name__c, Start_DateTime__c, Location__r.Name, Event_Detail__c, 
                Event_Organizer__r.Name FROM Event__c WHERE Start_DateTime__c >= :current];

    }
}
