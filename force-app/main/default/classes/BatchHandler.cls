public class BatchHandler {    
    public void dailyBatch() {
        Set<Id> batchProgressIds = new Set<Id>();
        batchProgressIds.add(Database.executeBatch(new ClearingEventsBatch()));
        
        AsyncApexJob jobs = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id IN :batchProgressIds];
        
        System.debug(jobs);
    }
}