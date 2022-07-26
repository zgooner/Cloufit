@isTest public class ErrorLogTest {
    @isTest static void addingError() {
        ErrorLogHandler.createErrorLog('123', 'details', date.newInstance(1991, 2, 21));
        
        List<Error_Log__c> errLg = [SELECT Id FROM Error_Log__c];
        System.assertEquals(1, errLg.size());
    }
}