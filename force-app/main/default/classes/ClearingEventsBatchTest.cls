@isTest
public class ClearingEventsBatchTest {
    @testSetup static void setup() {
        Integer eventsSize = 200;
        String[] startDates = new String[] {'2020-08-20 12:00:00', '2022-09-20 12:00:00'};
        String[] endDates = new String[] {'2020-08-27 12:00:00', '2022-09-27 12:00:00'};            
        List<Datetime> dtStart = TestDataFactory.createDatesFromStrings(startDates);
        List<Datetime> dtEnd = TestDataFactory.createDatesFromStrings(endDates);
        
        List<Event_Organizer__c> evOrg = TestDataFactory.createEventOrganizers(eventsSize);
        List<Event__c> events = new List<Event__c>();
        for (Integer i = 0; i < eventsSize; i++) {
        	events.add(new Event__c(Event_Organizer__c=evOrg[i].Id, Start_DateTime__c=dtStart[0], End_Date_Time__c=dtEnd[0], Max_Seats__c=100));
            events.add(new Event__c(Event_Organizer__c=evOrg[i].Id, Start_DateTime__c=dtStart[1], End_Date_Time__c=dtEnd[1], Max_Seats__c=100));
        }
        //można przecież dodać do tej samej listy i zrobić jeden insert. SF sobie sam to bulkuje, więc tym sposobem będzie dużo wydajniej :)
        // Naprawiono 12.08.2022
        insert events;
    }
    
    @isTest static void batchTest() {
        Test.startTest();
        Database.executeBatch(new ClearingEventsBatch());
        Test.stopTest();
        //bardzo fajnie, że testujesz z większą ilością rekordów. SF defaultowo dzieli rekordy na paczki po 200 sztuk, więc fajnie byłoby sprawdzić, co się stanie gdy będzie 250
        // Naprawiono 12.08.2022
        System.assertEquals(200, [SELECT count() FROM Event__c]);
    }
    
}
