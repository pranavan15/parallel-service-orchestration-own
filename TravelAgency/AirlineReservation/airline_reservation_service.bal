package TravelAgency.AirlineReservation;

import ballerina.net.http;

@http:configuration {basePath:"/airline", port:9091}
service<http> airlineReservationService {

    @http:resourceConfig {methods:["POST"], path:"/qatarAirways"}
    resource flightConcord (http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        json receivedPayload = request.getJsonPayload();
        json departureDate = receivedPayload.departure;
        json returnDate = receivedPayload.returnDate;
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json flightDetails = {
                                 "Flight":"Qatar Airways",
                                 "DepartureDate":departureDate,
                                 "ReturnDate":returnDate,
                                 "From":from,
                                 "To":to,
                                 "price":278
                             };
        response.setJsonPayload(flightDetails);
        _ = connection.respond(response);
    }

    @http:resourceConfig {methods:["POST"], path:"/asiana"}
    resource flightAsiana (http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        json receivedPayload = request.getJsonPayload();
        json departureDate = receivedPayload.departure;
        json returnDate = receivedPayload.returnDate;
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json flightDetails = {
                                 "Flight":"Asiana",
                                 "DepartureDate":departureDate,
                                 "ReturnDate":returnDate,
                                 "From":from,
                                 "To":to,
                                 "price":275
                             };
        response.setJsonPayload(flightDetails);
        _ = connection.respond(response);
    }

    @http:resourceConfig {methods:["POST"], path:"/emirates"}
    resource flightEmirates (http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        json receivedPayload = request.getJsonPayload();
        json departureDate = receivedPayload.departure;
        json returnDate = receivedPayload.returnDate;
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json flightDetails = {
                                 "Flight":"Emirates",
                                 "DepartureDate":departureDate,
                                 "ReturnDate":returnDate,
                                 "From":from,
                                 "To":to,
                                 "price":273
                             };
        response.setJsonPayload(flightDetails);
        _ = connection.respond(response);
    }
}
