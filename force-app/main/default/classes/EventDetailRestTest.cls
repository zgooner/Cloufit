@isTest
public class EventDetailRestTest {
    @testSetup static void setup() {
        String[] startDates = new String[] {'2022-05-20 12:00:00', '2022-09-20 12:00:00', '2022-10-20 12:00:00'};
        String[] endDates = new String[] {'2022-05-27 12:00:00', '2022-09-27 12:00:00', '2022-10-27 12:00:00'};
        TestDataFactory.createEvents(startDates, endDates);
    }
    @isTest static void getTest() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/Event__c/Live';
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        List<Event__c> events = EventDetailRestAPI.getLiveEventDetails();
        Test.stopTest();
        System.assertEquals(2, events.size());
    }
}