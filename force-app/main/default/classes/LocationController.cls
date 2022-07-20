public with sharing class LocationController {
    
    @AuraEnabled(cacheable=true)
    public static List<Location__c> getEventLocation(String eventId) {
        return [SELECT Id, City__c, Country__c, Land_Mark__c, Name, Postal_Code__c, State__c, Street__c, Verified__c,
                (SELECT Id FROM Events__r WHERE Id=:eventId) FROM Location__c LIMIT 1];
    }
}
