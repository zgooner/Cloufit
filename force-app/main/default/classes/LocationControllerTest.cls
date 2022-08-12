@isTest public class LocationControllerTest {
    @testSetup static void setup() {
        String[] startDates = new String[] {'2022-05-20 12:00:00', '2022-09-20 12:00:00', '2022-10-20 12:00:00'};
        String[] endDates = new String[] {'2022-05-27 12:00:00', '2022-09-27 12:00:00', '2022-10-27 12:00:00'};
        List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
    }

}
