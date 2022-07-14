@isTest
public class MockHttpResponseGenerator implements HttpCalloutMock  {
    private String typeOfResponse;
    
    public HTTPResponse respond(HTTPRequest req) {
        switch on typeOfResponse {
            when 'ValidReqSmarty' {
                HttpResponse res = new HttpResponse();
                res.setBody('{valid}');
                res.setStatusCode(200);
                return res;
            }
            when 'EmptyReqSmarty' {
               HttpResponse res = new HttpResponse();
                res.setBody('{}');
                res.setStatusCode(200);
                return res; 
            }
        }
        
        return null;
    }
    
    public void setValidSmartyResponse() {
        this.typeOfResponse = 'ValidReqSmarty';
    }
    
    public void setEmptySmartyResponse() {
        this.typeOfResponse = 'EmptyReqSmarty';
    }
}