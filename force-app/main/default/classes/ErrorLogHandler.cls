public class ErrorLogHandler {
    public static void createErrorLog(String processName, String logDetails, Date logDate) {
        Error_Log__c err = new Error_Log__c(
        					Log_Date_Time__c=logDate,
            				Log_Details__c=logDetails,
            				Process_Name__c=processName
        					);
        insert err;
    }

}