package TravelAgency.AirlineReservation;

import ballerina.net.http;

@http:configuration {basePath:"/airline", port:9091}
service<http> airlineReservationService {

    @http:resourceConfig {methods:["POST"], path:"/qatarAirways", consumes:["application/json"],
                          produces:["application/json"]}
    resource flightConcord (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json departureDate = receivedPayload.departure;
        json returnDate = receivedPayload.returnDate;
        json from = receivedPayload.from;
        json to = receivedPayload.to;

        if (departureDate == null || returnDate == null || from == null || to == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json flightDetails = {
                                 "Flight":"Qatar Airways",
                                 "DepartureDate":departureDate,
                                 "ReturnDate":returnDate,
                                 "From":from,
                                 "To":to,
                                 "price":278
                             };
        outResponse.setJsonPayload(flightDetails);
        _ = connection.respond(outResponse);
    }

    @http:resourceConfig {methods:["POST"], path:"/asiana", consumes:["application/json"],
                          produces:["application/json"]}
    resource flightAsiana (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json departureDate = receivedPayload.departure;
        json returnDate = receivedPayload.returnDate;
        json from = receivedPayload.from;
        json to = receivedPayload.to;

        if (departureDate == null || returnDate == null || from == null || to == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json flightDetails = {
                                 "Flight":"Asiana",
                                 "DepartureDate":departureDate,
                                 "ReturnDate":returnDate,
                                 "From":from,
                                 "To":to,
                                 "price":275
                             };
        outResponse.setJsonPayload(flightDetails);
        _ = connection.respond(outResponse);
    }

    @http:resourceConfig {methods:["POST"], path:"/emirates", consumes:["application/json"],
                          produces:["application/json"]}
    resource flightEmirates (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json departureDate = receivedPayload.departure;
        json returnDate = receivedPayload.returnDate;
        json from = receivedPayload.from;
        json to = receivedPayload.to;

        if (departureDate == null || returnDate == null || from == null || to == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json flightDetails = {
                                 "Flight":"Emirates",
                                 "DepartureDate":departureDate,
                                 "ReturnDate":returnDate,
                                 "From":from,
                                 "To":to,
                                 "price":273
                             };
        outResponse.setJsonPayload(flightDetails);
        _ = connection.respond(outResponse);
    }
}
