public with sharing class EventController {
    @AuraEnabled(cacheable=true)
    public static List<Event__c> getCurrentEvents() {
        Datetime current = System.now();
        return [SELECT Id, End_Date_Time__c, Name, Name__c, Start_DateTime__c, Location__c, Event_Detail__c, 
                Event_Organizer__c FROM Event__c WHERE Start_DateTime__c >= :current];        
    }
}
