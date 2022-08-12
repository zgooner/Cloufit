@isTest
public class CustomSearchControllerTest {
    @testSetup static void setup() {
        TestDataFactory.createAttendees(50);
    }
    
    @isTest static void failSearchForAttendeesByName() {
        Id[] fixedSearchResult = new Id[1];
        Test.setFixedSearchResults(fixedSearchResult);
        String answer = CustomSearchController.searchRecords('Attendee__c', 'Name', 'asdasda');
        //w sensie że miał nie znalezc? a pozytywny test?
        //Naprawiono 12.08.2022
        System.assertEquals('[[]]', answer);
    }

    @isTest static void searchForAtteendees() {
        Id[] fixedSearchResult = new Id[1];
        Attendee__c att = [SELECT Id FROM Attendee__c WHERE Name='test1'];
        fixedSearchResult[0] = att.Id;
        Test.setFixedSearchResults(fixedSearchResult);
        String answer = CustomSearchController.searchRecords('Attendee__c', 'Name', 'test1');
        System.assertNotEquals('[[]]', answer);
    }
}
