@isTest
public class LocationTriggerTest {    
    @isTest static void verifiedLocation() {
        MockHttpResponseGenerator mg = new MockHttpResponseGenerator();
        mg.setValidSmartyResponse();
        Test.setMock(HttpCalloutMock.class, mg);
        
        Location__c location = new Location__c(Name='asdasd', Street__c='aad', City__c='asdhdh', Postal_Code__c='sdad', Country__c='Poland', State__c='asdasd');
        Test.startTest();
        Database.SaveResult result = Database.insert(location);
        Test.stopTest();
        
        Location__c verifiedLocation = [SELECT Id, Verified__c FROM Location__c WHERE Name='asdasd'];
        System.assert(result.success);
        System.assertEquals(true, verifiedLocation.Verified__c);
   }
    
    @isTest static void notVerifiedLocation() {
        MockHttpResponseGenerator mg = new MockHttpResponseGenerator();
        mg.setEmptySmartyResponse();
        Test.setMock(HttpCalloutMock.class, mg);
        
        Location__c location = new Location__c(Name='asdasd', Street__c='aad', City__c='asdhdh', Postal_Code__c='sdad', Country__c='Poland', State__c='asdasd');
        Test.startTest();
        Database.SaveResult result = Database.insert(location);
        Test.stopTest();
        
        Location__c verifiedLocation = [SELECT Id, Verified__c FROM Location__c WHERE Name='asdasd'];
        System.assert(result.success);
        System.assertEquals(false, verifiedLocation.Verified__c);
    }
}