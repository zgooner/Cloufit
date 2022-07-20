public with sharing class SpeakerController {
    @AuraEnabled(cacheable=true)
    public static List<Speaker__c> getSpeakersRelatedWithEvent(String eventId) {
        List<Speaker__c> speakers = [SELECT Id, Name, Email__c, Company__c, (SELECT Id, Event__c FROM Event_Speakers__r WHERE Event__c =:eventId) FROM Speaker__c];

        return speakers;
    }

}
