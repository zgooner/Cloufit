public class LocationTriggerHandler implements TriggerHandler {
	private boolean triggerIsExecuting;
    private Integer triggerSize;
    public LocationTriggerHelper helper;
    public LocationTriggerHandler(boolean triggerIsExecuting, Integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new LocationTriggerHelper();
    }
    
    public void beforeInsert(List<Location__c> newLocations) {

    }
    public void beforeUpdate(List<Location__c> oldLocations, List<Location__c> newLocations, Map<ID, SObject> oldLocationsMap, Map<ID, SObject> newLocationsMap) {

    }
    public void beforeDelete(List<Location__c> oldLocations, Map<ID, SObject> oldLocationsMap) {
        
    }
    public void afterInsert(List<Location__c> newLocations, Map<ID, SObject> newLocationsMap) {
		helper.verifyLocations(newLocations);
    }
    public void afterUpdate(List<Location__c> oldLocations, List<Location__c> newEventAttendees, Map<ID, SObject> oldLocationsMap, Map<ID, SObject> newLocationsMap) {

    }
    public void afterDelete(List<Location__c> oldLocations, Map<ID, SObject> oldLocationsMap) {
        
    }
    public void afterUndelete(List<Location__c> newLocations, Map<ID, SObject> newLocationsMap) {
        
    }
}