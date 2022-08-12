@isTest 
public class DailyBatchTest {
    @isTest static void dailySchedulerTest() {
        DailyBatchScheduler dbs = new DailyBatchScheduler();
        String cronEXP = '0 0 23 * * ?';
        Test.startTest();
        String jobId = System.schedule('testDailyScheduledApex', cronEXP, dbs);
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
         NextFireTime
         FROM CronTrigger WHERE id = :jobId];
        
        System.assertEquals(cronEXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);


        System.assertEquals('2022-08-12 23:00:00', String.valueOf(ct.NextFireTime));
        Test.stopTest();
    }
}