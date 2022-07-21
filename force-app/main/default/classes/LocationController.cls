public with sharing class LocationController {
    
    @AuraEnabled(cacheable=true)
    public static List<Location__c> getEventLocation(String eventId) {
        Event__c event = [SELECT Id, Location__c FROM Event__c WHERE Id=:eventId LIMIT 1];
        List<Location__c> location = [SELECT Id, City__c, Country__c, Land_Mark__c, Name, Postal_Code__c, State__c, Street__c, Verified__c
                                            FROM Location__c WHERE Id=:event.Location__c];

        return location;
    }
}
