@isTest
public class EventAttendeeTriggerTest {
    @isTest static void sendingEmailTest() {
        List<Attendee__c> attendees = TestDataFactory.createAttendees(3);
        String[] startDates = new String[] {'2022-08-20 12:00:00', '2022-09-20 12:00:00', '2022-10-20 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00', '2022-09-27 12:00:00', '2022-10-27 12:00:00'};
        List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        
        List<Event_Attendee__c> evAtt = TestDataFactory.createEventAttendees(events, attendees);
        
        Test.startTest();
        Database.SaveResult[] results = Database.insert(evAtt, false);
        Test.stopTest();
        
        for (Database.SaveResult result : results) {
            System.debug(result.getErrors());
            System.assert(result.success);
        }
    }
    
    @isTest static void updateTest() {
        List<Attendee__c> attendees = TestDataFactory.createAttendees(2);
        String[] startDates = new String[] {'2022-08-20 12:00:00', '2022-09-20 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00', '2022-09-27 12:00:00'};
        List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        Event_Attendee__c eAtt = new Event_Attendee__c(Event__c=events[0].Id, Attendee__c=attendees[0].Id);
        List<Event_Attendee__c> eAList;
       	insert eAtt;
        
        eAList = [SELECT Id, Event__c, Attendee__c FROM Event_Attendee__c];
        eAList[0].Event__c = events[1].Id;
        eAlist[0].Attendee__c = attendees[1].Id;
        Test.startTest();
        Database.SaveResult[] results = Database.update(eAList, false);
        Test.stopTest();
        
        System.assert(results[0].success);
    }
    
    @isTest static void deleteTest() {
        List<Attendee__c> attendees = TestDataFactory.createAttendees(1);
        String[] startDates = new String[] {'2022-08-20 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00'};
        List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        Event_Attendee__c eAtt = new Event_Attendee__c(Event__c=events[0].Id, Attendee__c=attendees[0].Id);
        List<Event_Attendee__c> eAList = new List<Event_Attendee__c> {eAtt};
       	insert eAtt;
        
        Test.startTest();
        Database.DeleteResult[] results = Database.delete(eAList, false);
        Test.stopTest();
        
        System.assert(results[0].success);
        
    }
    
    @isTest static void unDeleteTest() {
        List<Attendee__c> attendees = TestDataFactory.createAttendees(1);
        String[] startDates = new String[] {'2022-08-20 12:00:00'};
        String[] endDates = new String[] {'2022-08-27 12:00:00'};
        List<Event__c> events = TestDataFactory.createEvents(startDates, endDates);
        Event_Attendee__c eAtt = new Event_Attendee__c(Event__c=events[0].Id, Attendee__c=attendees[0].Id);
        List<Event_Attendee__c> eAList = new List<Event_Attendee__c> {eAtt};
       	insert eAtt;
        delete eAtt;
        
        Test.startTest();
        Database.UndeleteResult[] results = Database.undelete(eAList, false);
        Test.stopTest();
        
        System.assert(results[0].success);
        
    }
}