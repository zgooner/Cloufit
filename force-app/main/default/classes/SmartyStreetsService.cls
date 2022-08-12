public class SmartyStreetsService {
	
    public static Boolean verifyLocations(String country, String state, String city, String postalCode, String street) {
        HttpRequest request = new HttpRequest();

        String endPoint = 'https://international-street.api.smartystreets.com/verify?auth-id=cfd05c51-3b35-1b66-b384-acd6a19f1b0e&auth-token=moJhYJHWV8kdKKRuR3xY' +
                				'&country='+ country +'&address1='+ street +'&address2=&locality='+ city +'&administrative_area='+ state +
                				'&postal_code='+ postalCode;

        request.setEndpoint(endPoint.replace(' ', '%20'));
        request.setMethod('GET');
            
        try {
            HttpResponse response = new HTTP().send(request);
			System.debug(response.getBody());
            if (response.getStatusCode() == 200 && !response.getBody().equals('{}')) {
                return true;
            } 
         } catch (System.CalloutException e) {
             ErrorLogHandler.createErrorLog('SmartyAPI', e.getStackTraceString(), System.now());
         }
        
        return false;
    }
}