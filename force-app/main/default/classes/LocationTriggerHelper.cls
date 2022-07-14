public class LocationTriggerHelper {
    public void verifyLocations(List<Location__c> newLocations) {
        List<String> listOfLocationNames = new List<String>();
        
        for (Location__c loc : newLocations) {
            listOfLocationNames.add(loc.Name);
        }
        
        helperVerifyingLocations(listOfLocationNames);
    }
    
    @future(callout=true)
    static void helperVerifyingLocations(List<String> locations) {
        List<Location__c> locationsToVerify = [SELECT Id, Country__c, State__c, City__c, Postal_Code__c, Street__c, Verified__c FROM Location__c WHERE Name IN :locations];
        List<Location__c> locationsToUpdate = new List<Location__c>();
        
        for (Location__c location : locationsToVerify) {
            if(SmartyStreetsService.verifyLocations(location.Country__c, location.State__c, location.City__c, location.Postal_Code__c, location.Street__c)) {
                location.Verified__c = true;
                locationsToUpdate.add(location);
            }
        }
        
        update locationsToUpdate;
    }
}