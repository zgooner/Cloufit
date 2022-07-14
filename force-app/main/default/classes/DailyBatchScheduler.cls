public class DailyBatchScheduler implements Schedulable {
    private BatchHandler bh = new BatchHandler();
  	  public void execute(SchedulableContext sc) {
      bh.dailyBatch();
   }
}