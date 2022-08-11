public class BatchHandler {    
    public void dailyBatch() {
        Set<Id> batchProgressIds = new Set<Id>();
        batchProgressIds.add(Database.executeBatch(new ClearingEventsBatch()));
        // coś dalej się z tym 'jobs'? Jeśli nie, to unused variable
        AsyncApexJob jobs = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id IN :batchProgressIds];
    }
}
