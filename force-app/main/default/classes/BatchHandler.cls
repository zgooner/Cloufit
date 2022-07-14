public class BatchHandler {    
    public void dailyBatch() {
        Database.executeBatch(new ClearingEventsBatch());
    }
}