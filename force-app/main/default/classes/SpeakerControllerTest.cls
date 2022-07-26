@isTest public class SpeakerControllerTest {

    @testSetup static void setup() {
        String[] startDates = new String[] {'2022-08-20 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00'};
        List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        List<Speaker__c> speakers = TestDataFactory.createSpeakers(5);
        EventSpeakers__c es1 = new EventSpeakers__c(Event__c=events[0].Id, Speaker__c=speakers[0].Id);
        EventSpeakers__c es2 = new EventSpeakers__c(Event__c=events[0].Id, Speaker__c=speakers[1].Id);
        insert es1;
        insert es2;
    }
    
    
    @isTest static void speakerRelatedWithEventTest() {
        Event__c ev = [SELECT Id FROM Event__c LIMIT 1];
        List<Speaker__c> speakers = SpeakerController.getSpeakersRelatedWithEvent(ev.Id);
        System.assertEquals(2, speakers.size());
    }
    
    @isTest static void allSpeakersTest() {
        List<Speaker__c> speakers = SpeakerController.getAllSpeakers();
        System.assertEquals(5, speakers.size());
    }
}