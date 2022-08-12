public class BatchHandler {    
    public void dailyBatch() {
        Set<Id> batchProgressIds = new Set<Id>();
        batchProgressIds.add(Database.executeBatch(new ClearingEventsBatch()));
        // coś dalej się z tym 'jobs'? Jeśli nie, to unused variable
        // Naprawiono 12.08.2022
        AsyncApexJob jobs = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id IN :batchProgressIds];

            if (jobs.NumberOfErrors > 0) {
                ErrorLogHandler.createErrorLog('Daily Batch', 'The batch Apex job processed ' + jobs.TotalJobItems +
                ' batches with '+ jobs.NumberOfErrors + ' failures.', System.now());
            }
    }
}
