public class LocationTriggerHelper {
    
    public void verifyLocations(List<Location__c> newLocations) {
        List<String> listOfLocationNames = new List<String>();
        
        for (Location__c loc : newLocations) {
            listOfLocationNames.add(loc.Name);
        }
        
        verifyLocation(listOfLocationNames);
    }
    
    @future(callout=true)
    private static void verifyLocation(String[] locationNames) {
        HttpRequest request = new HttpRequest();
        
        List<Location__c> locations = [SELECT Id, Street__c, City__c, State__c, Postal_Code__c, Verified__c FROM Location__c WHERE Name IN :locationNames];
        for(Location__c location : locations) {
            String preparedStreet = location.Street__c.replace(' ', '%20');
            String preparedCity = location.City__c.replace(' ', '%20');
            String endPoint = 'https://us-street.api.smartystreets.com/street-address?street='+ preparedStreet +
                                '&city='+ preparedCity +'&state='+ location.State__c +'&zipcode=' + location.Postal_Code__c +
                				'&auth-id=cfd05c51-3b35-1b66-b384-acd6a19f1b0e&auth-token=moJhYJHWV8kdKKRuR3xY';

            request.setEndpoint(endPoint);
            request.setMethod('GET');
            
            try {
                HttpResponse response = new HTTP().send(request);

                if (response.getStatusCode() == 200 && !String.isEmpty(response.getBody())) {
                    location.Verified__c = true;
                    update location;
                } 
            } catch (System.CalloutException e) {
                System.debug(e);
            }
            
        }
    }
}