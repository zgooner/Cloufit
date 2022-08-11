@isTest
public class AttendeeControllerTest {
    @testSetup static void setup() {
        TestDataFactory.createAttendees(50); //attendees without event attendees
        String[] startDates = new String[] {'2022-08-20 12:00:00', '2022-09-20 12:00:00', '2022-10-20 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00', '2022-09-27 12:00:00', '2022-10-27 12:00:00'};
        List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        Attendee__c att1 = new Attendee__c(Name='test51', Email__c='test51@testy.com', Phone__c=String.valueOf('51'));
        Attendee__c att2 = new Attendee__c(Name='test52', Email__c='test52@testy.com', Phone__c=String.valueOf('52'));
        Attendee__c att3 = new Attendee__c(Name='test53', Email__c='test53@testy.com', Phone__c=String.valueOf('53'));
        List<Attendee__c> nAtt = new List<Attendee__c> {att1, att2, att3};
        insert nAtt;
        List<Event_Attendee__c> evAtt = TestDataFactory.createEventAttendees(events, nAtt);
        System.debug(evAtt);
        insert evAtt;
    }
    
    @isTest
    static void searchingForAttendeesWithEvents() {
        Event__c ev = [SELECT Id FROM Event__c LIMIT 1];
        List<Attendee__c> attendees = AttendeeController.getEventAttendees(ev.Id);
        System.debug(attendees.size());  //wyrzuć debugi. Starajmy się dostarczać czysty kod
        System.debug(ev);
        System.assertEquals(1, attendees.size());
    }
}
