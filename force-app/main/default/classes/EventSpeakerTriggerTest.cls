@isTest 
public class EventSpeakerTriggerTest {
    @isTest static void validInsert() {
        Integer numberOfRecords = 3;
        List<Speaker__c> speakersList = TestDataFactory.createSpeakers(numberOfRecords);
        String[] startDates = new String[] {'2022-08-20 12:00:00', '2022-09-20 12:00:00', '2022-10-20 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00', '2022-09-27 12:00:00', '2022-10-27 12:00:00'};
       	List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        System.debug(events);
        List<EventSpeakers__c> eSpeakers = TestDataFactory.createEventSpeakers(events, speakersList);
		
        Test.startTest();
       	Database.SaveResult[] results = Database.insert(eSpeakers, false);
        Test.stopTest();
        for (Database.SaveResult result : results) {
            System.assert(result.success);
        }
    }
}