package TravelAgency.AirlineReservation;

import ballerina.net.http;

// Airline reservation service
@http:configuration {basePath:"/airline", port:9091}
service<http> airlineReservationService {
    // Resource 'flightConcord', which checks about airline 'Qatar Airways'
    @http:resourceConfig {methods:["POST"], path:"/qatarAirways", consumes:["application/json"],
                          produces:["application/json"]}
    resource flightConcord (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};

        // Try parsing the JSON payload from the request
        json receivedPayload = inRequest.getJsonPayload();
        json arrivalDate = receivedPayload.ArrivalDate;
        json departureDate = receivedPayload.DepartureDate;
        json from = receivedPayload.From;
        json to = receivedPayload.To;

        // If payload parsing fails, send a "Bad Request" message as the response
        if (arrivalDate == null || departureDate == null || from == null || to == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        // Mock logic
        // Details of the airline
        json flightDetails = {
                                 "Airline":"Qatar Airways",
                                 "ArrivalDate":arrivalDate,
                                 "ReturnDate":departureDate,
                                 "From":from,
                                 "To":to,
                                 "Price":278
                             };
        // Response payload
        outResponse.setJsonPayload(flightDetails);
        // Send the response to the client
        _ = connection.respond(outResponse);
    }

    // Resource 'flightAsiana', which checks about airline 'Asiana'
    @http:resourceConfig {methods:["POST"], path:"/asiana", consumes:["application/json"],
                          produces:["application/json"]}
    resource flightAsiana (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};

        // Try parsing the JSON payload from the request
        json receivedPayload = inRequest.getJsonPayload();
        json arrivalDate = receivedPayload.ArrivalDate;
        json departureDate = receivedPayload.DepartureDate;
        json from = receivedPayload.From;
        json to = receivedPayload.To;

        // If payload parsing fails, send a "Bad Request" message as the response
        if (arrivalDate == null || arrivalDate == null || from == null || to == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        // Mock logic
        // Details of the airline
        json flightDetails = {
                                 "Airline":"Asiana",
                                 "ArrivalDate":arrivalDate,
                                 "ReturnDate":departureDate,
                                 "From":from,
                                 "To":to,
                                 "Price":275
                             };
        // Response payload
        outResponse.setJsonPayload(flightDetails);
        // Send the response to the client
        _ = connection.respond(outResponse);
    }

    // Resource 'flightEmirates', which checks about airline 'Emirates'
    @http:resourceConfig {methods:["POST"], path:"/emirates", consumes:["application/json"],
                          produces:["application/json"]}
    resource flightEmirates (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};

        // Try parsing the JSON payload from the request
        json receivedPayload = inRequest.getJsonPayload();
        json arrivalDate = receivedPayload.ArrivalDate;
        json departureDate = receivedPayload.DepartureDate;
        json from = receivedPayload.From;
        json to = receivedPayload.To;

        // If payload parsing fails, send a "Bad Request" message as the response
        if (arrivalDate == null || departureDate == null || from == null || to == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        // Mock logic
        // Details of the airline
        json flightDetails = {
                                 "Airline":"Emirates",
                                 "ArrivalDate":arrivalDate,
                                 "ReturnDate":departureDate,
                                 "From":from,
                                 "To":to,
                                 "Price":273
                             };
        // Response payload
        outResponse.setJsonPayload(flightDetails);
        // Send the response to the client
        _ = connection.respond(outResponse);
    }
}
