package TravelAgency.AirlineReservation;

import ballerina.test;
import ballerina.net.http;

// Common request Payload
json requestPayload = {
                          "ArrivalDate":"12-03-2018",
                          "DepartureDate":"13-04-2018",
                          "From":"Colombo",
                          "To":"Changi"
                      };

// Create HTTP Client
http:HttpClient httpClient = create http:HttpClient("http://localhost:9091/airline", {});

// Start the service before running the tests
function beforeTest () {
    _ = test:startService("airlineReservationService");
}

// Function to test resource 'flightConcord'
function testResourceFlightConcord () {
    endpoint<http:HttpClient> httpEndpoint {
        httpClient;
    }
    // Initialize the empty http requests and responses
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError err;

    // Set request payload
    request.setJsonPayload(requestPayload);
    // Send a 'post' request and obtain the response
    response, err = httpEndpoint.post("/qatarAirways", request);
    // 'err' is expected to be null
    test:assertTrue(err == null, "Error: Cannot reserve airline ticket!");
    // Expected response code is 200
    test:assertIntEquals(response.statusCode, 200, "Airline reservation service did not respond with 200 OK signal!");
    // Check whether the response is as expected
    string expected = "{\"Airline\":\"Qatar Airways\",\"ArrivalDate\":\"12-03-2018\",\"ReturnDate\":\"13-04-2018\"," +
                      "\"From\":\"Colombo\",\"To\":\"Changi\",\"Price\":278}";
    test:assertStringEquals(response.getJsonPayload().toString(), expected, "Response mismatch!");
}

// Function to test resource 'flightAsiana'
function testResourceFlightAsiana () {
    endpoint<http:HttpClient> httpEndpoint {
        httpClient;
    }
    // Initialize the empty http requests and responses
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError err;

    // Set request payload
    request.setJsonPayload(requestPayload);
    // Send a 'post' request and obtain the response
    response, err = httpEndpoint.post("/asiana", request);
    // 'err' is expected to be null
    test:assertTrue(err == null, "Error: Cannot reserve airline ticket!");
    // Expected response code is 200
    test:assertIntEquals(response.statusCode, 200, "Airline reservation service did not respond with 200 OK signal!");
    // Check whether the response is as expected
    string expected = "{\"Airline\":\"Asiana\",\"ArrivalDate\":\"12-03-2018\",\"ReturnDate\":\"13-04-2018\"," +
                      "\"From\":\"Colombo\",\"To\":\"Changi\",\"Price\":275}";
    test:assertStringEquals(response.getJsonPayload().toString(), expected, "Response mismatch!");
}

// Function to test resource 'flightEmirates'
function testResourceFlightEmirates () {
    endpoint<http:HttpClient> httpEndpoint {
        httpClient;
    }
    // Initialize the empty http requests and responses
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError err;

    // Set request payload
    request.setJsonPayload(requestPayload);
    // Send a 'post' request and obtain the response
    response, err = httpEndpoint.post("/emirates", request);
    // 'err' is expected to be null
    test:assertTrue(err == null, "Error: Cannot reserve airline ticket!");
    // Expected response code is 200
    test:assertIntEquals(response.statusCode, 200, "Airline reservation service did not respond with 200 OK signal!");
    // Check whether the response is as expected
    string expected = "{\"Airline\":\"Emirates\",\"ArrivalDate\":\"12-03-2018\",\"ReturnDate\":\"13-04-2018\"," +
                      "\"From\":\"Colombo\",\"To\":\"Changi\",\"Price\":273}";
    test:assertStringEquals(response.getJsonPayload().toString(), expected, "Response mismatch!");
}
