@isTest 
public class EventSpeakerTriggerTest {
    
    @testSetup static void setup() {
        //tu nic nie ma :(  a mogłybyć np. Speakerzy, eventy... :)
    }
    
    @isTest static void validInsert() {
        Integer numberOfRecords = 3;
        List<Speaker__c> speakersList = TestDataFactory.createSpeakers(numberOfRecords);
        String[] startDates = new String[] {'2022-08-20 12:00:00', '2022-09-20 12:00:00', '2022-10-20 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00', '2022-09-27 12:00:00', '2022-10-27 12:00:00'};
       	List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        List<EventSpeakers__c> eSpeakers = TestDataFactory.createEventSpeakers(events, speakersList);
        System.debug(eSpeakers);
        Test.startTest();
       	Database.SaveResult[] results = Database.insert(eSpeakers, true);
        Test.stopTest();
        for (Database.SaveResult result : results) {
            System.debug(result.getErrors());
            System.assert(result.success);
        }
    }
    
    @isTest static void invalidRecordsAtSameTimeTest() {
        List<Speaker__c> speakersList = TestDataFactory.createSpeakers(2);
        String[] startDates = new String[] {'2022-08-20 12:00:00', '2022-08-10 12:00:00', '2022-08-10 12:00:00', '2022-08-9 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00', '2022-08-21 12:00:00', '2022-08-28 12:00:00', '2022-08-27 12:00:00'};
        List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        EventSpeakers__c es1 = new EventSpeakers__c(Event__c=events[0].Id, Speaker__c=speakersList[0].Id);
        EventSpeakers__c es2 = new EventSpeakers__c(Event__c=events[1].Id, Speaker__c=speakersList[0].Id);
        List<EventSpeakers__c> esList = new List<EventSpeakers__c> {es1, es2};
            
        Test.startTest();
       	Database.SaveResult[] results = Database.insert(esList, false);
        Test.stopTest();
        
        System.assert(results[0].success);
        System.assert(!results[1].success);
    }
    
    @isTest static void invalidRecordOneByAnother() {
        List<Speaker__c> speakersList = TestDataFactory.createSpeakers(2);
        String[] startDates = new String[] {'2022-08-20 12:00:00', '2022-08-10 12:00:00', '2022-08-10 12:00:00', '2022-08-9 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00', '2022-08-21 12:00:00', '2022-08-28 12:00:00', '2022-08-27 12:00:00'};
        List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        EventSpeakers__c es1 = new EventSpeakers__c(Event__c=events[0].Id, Speaker__c=speakersList[0].Id);
        EventSpeakers__c es2 = new EventSpeakers__c(Event__c=events[1].Id, Speaker__c=speakersList[0].Id);
        insert es1;
        EventSpeakers__c es3 = new EventSpeakers__c(Event__c=events[2].Id, Speaker__c=speakersList[1].Id);
        insert es3;
        EventSpeakers__c es4 = new EventSpeakers__c(Event__c=events[3].Id, Speaker__c=speakersList[1].Id);
        List<EventSpeakers__c> esList = new List<EventSpeakers__c> {es2, es4};
            
        Database.SaveResult[] results = new List<Database.SaveResult>();
        Test.startTest();
        for (EventSpeakers__c es : esList) {
            results.add(Database.insert(es, false));
        }
        Test.stopTest();
        
        for (Database.SaveResult result : results) {
            System.debug(result.getErrors());
            System.assert(!result.success);
        }
    }
    
    @isTest static void validUpdate() {
        Integer numberOfRecords = 2;
        List<Speaker__c> speakersList = TestDataFactory.createSpeakers(numberOfRecords);
        String[] startDates = new String[] {'2022-08-20 12:00:00', '2022-09-20 12:00:00', '2022-10-20 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00', '2022-09-27 12:00:00', '2022-10-27 12:00:00'};
       	List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        EventSpeakers__c es1 = new EventSpeakers__c(Event__c=events[0].Id, Speaker__c=speakersList[0].Id);
        EventSpeakers__c es2 = new EventSpeakers__c(Event__c=events[1].Id, Speaker__c=speakersList[1].Id);
		insert es1;
        insert es2;
        
        es1.Event__r= events[1];
       	es2.Event__r= events[2];
                              
        List<EventSpeakers__c> esList = new List<EventSpeakers__c> {es1, es2};

        Test.startTest();
       	Database.SaveResult[] results = Database.update(esList, false);
        Test.stopTest();
        for (Database.SaveResult result : results) {
            System.debug(result.getErrors());
            System.assert(result.success);
        }
    }
    
    @isTest static void invalidUpdate() {
        Integer numberOfRecords = 1;
        List<Speaker__c> speakersList = TestDataFactory.createSpeakers(numberOfRecords);
        String[] startDates = new String[] {'2022-08-20 12:00:00', '2022-08-23 12:00:00', '2022-10-20 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00', '2022-08-26 12:00:00', '2022-10-27 12:00:00'};
       	List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);

        EventSpeakers__c es1 = new EventSpeakers__c(Event__c=events[0].Id, Speaker__c=speakersList[0].Id);
        EventSpeakers__c es2 = new EventSpeakers__c(Event__c=events[2].Id, Speaker__c=speakersList[0].Id);

        List<EventSpeakers__c> esList;
        Set<Id> esIDs = new Set<Id> {es1.Id, es2.Id};
		insert es1;
        insert es2;
        
        esList = [SELECT Id, Event__c, Speaker__c FROM EventSpeakers__c];
        esList[1].Event__c = events[1].Id;

        Test.startTest();
        Database.SaveResult[] results = Database.update(esList, false);
        Test.stopTest();
        
        System.assert(results[0].success);
        System.assert(!results[1].success);
    }
    
    @isTest static void deletionTest() {
        Integer numberOfRecords = 1;
        List<Speaker__c> speakersList = TestDataFactory.createSpeakers(numberOfRecords);
        String[] startDates = new String[] {'2022-08-20 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00'};
        List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        List<EventSpeakers__c> esList = TestDataFactory.createEventSpeakers(events, speakersList);
        insert esList;
        Test.startTest();
        Database.DeleteResult[] results = Database.delete(esList);
        Test.stopTest();
        System.assert(results[0].success);
    }
    
    @isTest static void undeletionTest() {
        Integer numberOfRecords = 1;
        List<Speaker__c> speakersList = TestDataFactory.createSpeakers(numberOfRecords);
        String[] startDates = new String[] {'2022-08-20 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00'};
        List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        List<EventSpeakers__c> esList = TestDataFactory.createEventSpeakers(events, speakersList);
        insert esList;
        delete esList;
        Test.startTest();
        Database.UndeleteResult[] results = Database.undelete(esList);
        Test.stopTest();
        System.assert(results[0].success);
    }

}
