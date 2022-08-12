public class ClearingEventsBatch implements Database.Batchable<sObject> {
	public Database.QueryLocator start(Database.BatchableContext bc) {
		//tu można użyć np. LAST_N_DAYS:60, albo czegoś podobno z miesiącami. dateBorder będzie wtedy zbędne :)
        //Naprawiono 12.08.2022
        return Database.getQueryLocator([SELECT Id, Live__c, End_Date_Time__c FROM Event__c WHERE End_Date_Time__c < LAST_N_DAYS:60 AND Live__c=false]);
    }
    public void execute(Database.BatchableContext bc, List<Event__c> records){
   		delete records;
    }
    public void finish(Database.BatchableContext bc){
        EmailHandler.sendSimpleMessage('kacper.konopka18@gmail.com', 'Execution of the batch has been processed.');
    }
}
