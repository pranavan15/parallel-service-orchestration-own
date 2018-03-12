package TravelAgency.HotelReservation;

import ballerina.net.http;

// Hotel reservation service
@http:configuration {basePath:"/hotel", port:9092}
service<http> hotelReservationService {
    // Resource 'miramar', which checks about hotel 'Miramar'
    @http:resourceConfig {methods:["POST"], path:"/miramar", consumes:["application/json"],
                          produces:["application/json"]}
    resource miramar (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};

        // Try parsing the JSON payload from the request
        json receivedPayload = inRequest.getJsonPayload();
        json arrivalDate = receivedPayload.ArrivalDate;
        json departureDate = receivedPayload.DepartureDate;
        json location = receivedPayload.Location;

        // If payload parsing fails, send a "Bad Request" message as the response
        if (arrivalDate == null || departureDate == null || location == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        // Mock logic
        // Details of the hotel
        json hotelDetails = {
                                "HotelName":"Miramar",
                                "FromDate":arrivalDate,
                                "ToDate":departureDate,
                                "DistanceToLocation":6
                            };
        // Response payload
        outResponse.setJsonPayload(hotelDetails);
        // Send the response to the client
        _ = connection.respond(outResponse);
    }

    // Resource 'aqueen', which checks about hotel 'Aqueen'
    @http:resourceConfig {methods:["POST"], path:"/aqueen", consumes:["application/json"],
                          produces:["application/json"]}
    resource aqueen (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};

        // Try parsing the JSON payload from the request
        json receivedPayload = inRequest.getJsonPayload();
        json arrivalDate = receivedPayload.ArrivalDate;
        json departureDate = receivedPayload.DepartureDate;
        json location = receivedPayload.Location;

        // If payload parsing fails, send a "Bad Request" message as the response
        if (arrivalDate == null || departureDate == null || location == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        // Mock logic
        // Details of the hotel
        json hotelDetails = {
                                "HotelName":"Aqueen",
                                "FromDate":arrivalDate,
                                "ToDate":departureDate,
                                "DistanceToLocation":4
                            };
        // Response payload
        outResponse.setJsonPayload(hotelDetails);
        // Send the response to the client
        _ = connection.respond(outResponse);
    }

    // Resource 'elizabeth', which checks about hotel 'Elizabeth'
    @http:resourceConfig {methods:["POST"], path:"/elizabeth", consumes:["application/json"],
                          produces:["application/json"]}
    resource elizabeth (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};

        // Try parsing the JSON payload from the request
        json receivedPayload = inRequest.getJsonPayload();
        json arrivalDate = receivedPayload.ArrivalDate;
        json departureDate = receivedPayload.DepartureDate;
        json location = receivedPayload.Location;

        // If payload parsing fails, send a "Bad Request" message as the response
        if (arrivalDate == null || departureDate == null || location == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        // Mock logic
        // Details of the hotel
        json hotelDetails = {
                                "HotelName":"Elizabeth",
                                "FromDate":arrivalDate,
                                "ToDate":departureDate,
                                "DistanceToLocation":2
                            };
        // Response payload
        outResponse.setJsonPayload(hotelDetails);
        // Send the response to the client
        _ = connection.respond(outResponse);
    }
}
