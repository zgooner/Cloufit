@isTest 
public class EventControllerTest {
    
    
    @testSetup static void setup() {
        MockHttpResponseGenerator mg = new MockHttpResponseGenerator();
        mg.setValidSmartyResponse();
        Test.setMock(HttpCalloutMock.class, mg);
        String[] startDates = new String[] {'2022-05-20 12:00:00', '2022-09-20 12:00:00', '2022-10-20 12:00:00'};
        String[] endDates = new String[] {'2022-05-27 12:00:00', '2022-09-27 12:00:00', '2022-10-27 12:00:00'};
        List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        Attendee__c att = new Attendee__c(Name='test123', Email__c='test@wp.pl', Phone__c=String.valueOf('55'));
        insert att;
        Event_Attendee__c evAtt1 = new Event_Attendee__c(Event__c=events[0].id, Attendee__c = att.Id);
        insert evAtt1;
        Event_Attendee__c evAtt2 = new Event_Attendee__c(Event__c=events[2].id, Attendee__c = att.Id);
        insert evAtt2;
    }
    
    @isTest static void currentEventsTest() {
        List<Event__c> ev = EventController.getCurrentEvents();
        System.assertEquals(2, ev.size());
    }
    
    @isTest static void specifiedEventTest() {
        String s = null;
        Location__c loc = [SELECT Id FROM Location__c LIMIT 1];
        List<Event__c> ev = EventController.getSpecifiedEvents(s, loc.Id, '2022-09-28 12:00:00');
        System.assertEquals(0, ev.size());
        ev = EventController.getSpecifiedEvents(s, null, '2022-09-28 12:00:00');
        System.assertEquals(1, ev.size());
    }
    
    @isTest static void upcomingEvents() {
        Attendee__c att = [SELECT Id FROM Attendee__c LIMIT 1];
        
        List<Event__c> ev = EventController.getAttendeesUpcomingEvents(att.Id);
        
        System.assertEquals(1, ev.size());
    }
    
    @isTest static void pastEvents() {
        Attendee__c att = [SELECT Id FROM Attendee__c LIMIT 1];
        
        List<Event__c> ev = EventController.getAttendeesPastEvents(att.Id);
        
        System.assertEquals(1, ev.size());
    }
}