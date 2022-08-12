public with sharing class SpeakerController {
    @AuraEnabled(cacheable=true)
    public static List<Speaker__c> getSpeakersRelatedWithEvent(String eventId) {
        //zwróci wszystkich speakerów... na pewno tego chcemy?
        //Naprawiono 12.08.2022
        List<EventSpeakers__c> eSpeakers = [SELECT Id, Event__c, Speaker__c FROM EventSpeakers__c WHERE Event__c =:eventId];
        Set<Id> speakerIds = new Set<Id>();

        for (EventSpeakers__c es : eSpeakers) {
            speakerIds.add(es.Speaker__c);
        }


        return  [SELECT Id, Name, Email__c, Company__c FROM Speaker__c WHERE Id IN :speakerIds];
    }

    @AuraEnabled(cacheable=true)
    public static List<Speaker__c> getAllSpeakers() {
        return [SELECT Id, Name, Email__c, About_Me__c FROM Speaker__c];
    }

}
