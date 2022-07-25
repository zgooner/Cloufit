@RestResource(urlMapping='/Event__c/Live')
global class EventDetailRestAPI {
    
    @HttpGet
    global static List<Event__c> getLiveEventDetails() {
        // Map<string, string> paramsMap = RestContext.request.params;
        // String evId = paramsMap.get('Id');
        return [SELECT Id, Event_Detail__c, Name, Name__c FROM Event__c WHERE Live__c=true AND Start_DateTime__c >= :System.now()];
    }
}