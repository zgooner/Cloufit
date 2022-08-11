@isTest
public class CustomSearchControllerTest {
    @testSetup static void setup() {
        TestDataFactory.createAttendees(50);
    }
    
    @isTest static void searchForAttendeesByName() {
        List<Attendee__c> att = [SELECT Id, Name FROM Attendee__c];
        System.debug(att);
        String answer = CustomSearchController.searchRecords('Attendee__c', 'Name', 'asdasda');
        //w sensie że miał nie znalezc? a pozytywny test?
        System.assertEquals('[[]]', answer);
    }
}
