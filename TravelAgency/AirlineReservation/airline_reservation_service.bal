package TravelAgency.AirlineReservation;

import ballerina.net.http;

@http:configuration {basePath:"/airline", port:9091}
service<http> airlineReservationService {

    @http:resourceConfig {methods:["POST"], path:"/qatarAirways", consumes:["application/json"],
                          produces:["application/json"]}
    resource flightConcord (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json arrivalDate = receivedPayload.ArrivalDate;
        json departureDate = receivedPayload.DepartureDate;
        json from = receivedPayload.From;
        json to = receivedPayload.To;

        if (arrivalDate == null || departureDate == null || from == null || to == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json flightDetails = {
                                 "Airline":"Qatar Airways",
                                 "ArrivalDate":arrivalDate,
                                 "ReturnDate":departureDate,
                                 "From":from,
                                 "To":to,
                                 "Price":278
                             };
        outResponse.setJsonPayload(flightDetails);
        _ = connection.respond(outResponse);
    }

    @http:resourceConfig {methods:["POST"], path:"/asiana", consumes:["application/json"],
                          produces:["application/json"]}
    resource flightAsiana (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json arrivalDate = receivedPayload.ArrivalDate;
        json departureDate = receivedPayload.DepartureDate;
        json from = receivedPayload.From;
        json to = receivedPayload.To;

        if (arrivalDate == null || arrivalDate == null || from == null || to == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json flightDetails = {
                                 "Airline":"Asiana",
                                 "ArrivalDate":arrivalDate,
                                 "ReturnDate":arrivalDate,
                                 "From":from,
                                 "To":to,
                                 "Price":275
                             };
        outResponse.setJsonPayload(flightDetails);
        _ = connection.respond(outResponse);
    }

    @http:resourceConfig {methods:["POST"], path:"/emirates", consumes:["application/json"],
                          produces:["application/json"]}
    resource flightEmirates (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json arrivalDate = receivedPayload.ArrivalDate;
        json departureDate = receivedPayload.DepartureDate;
        json from = receivedPayload.From;
        json to = receivedPayload.To;

        if (arrivalDate == null || departureDate == null || from == null || to == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json flightDetails = {
                                 "Airline":"Emirates",
                                 "ArrivalDate":arrivalDate,
                                 "ReturnDate":departureDate,
                                 "From":from,
                                 "To":to,
                                 "Price":273
                             };
        outResponse.setJsonPayload(flightDetails);
        _ = connection.respond(outResponse);
    }
}
