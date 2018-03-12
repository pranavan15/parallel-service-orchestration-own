package TravelAgency.HotelReservation;

import ballerina.net.http;

@http:configuration {basePath:"/hotel", port:9092}
service<http> hotelReservationService {

    @http:resourceConfig {methods:["POST"], path:"/miramar", consumes:["application/json"],
                          produces:["application/json"]}
    resource miramar (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json arrivalDate = receivedPayload.ArrivalDate;
        json departureDate = receivedPayload.DepartureDate;
        json location = receivedPayload.Location;

        if (arrivalDate == null || departureDate == null || location == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json hotelDetails = {
                                "HotelName":"miramar",
                                "FromDate":arrivalDate,
                                "ToDate":departureDate,
                                "DistanceToLocation":6
                            };
        outResponse.setJsonPayload(hotelDetails);
        _ = connection.respond(outResponse);
    }

    @http:resourceConfig {methods:["POST"], path:"/aqueen", consumes:["application/json"],
                          produces:["application/json"]}
    resource aqueen (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json arrivalDate = receivedPayload.ArrivalDate;
        json departureDate = receivedPayload.DepartureDate;
        json location = receivedPayload.Location;

        if (arrivalDate == null || departureDate == null || location == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json hotelDetails = {
                                "HotelName":"aqueen",
                                "FromDate":arrivalDate,
                                "ToDate":departureDate,
                                "DistanceToLocation":4
                            };
        outResponse.setJsonPayload(hotelDetails);
        _ = connection.respond(outResponse);
    }

    @http:resourceConfig {methods:["POST"], path:"/elizabeth", consumes:["application/json"],
                          produces:["application/json"]}
    resource elizabeth (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json arrivalDate = receivedPayload.ArrivalDate;
        json departureDate = receivedPayload.DepartureDate;
        json location = receivedPayload.Location;

        if (arrivalDate == null || departureDate == null || location == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json hotelDetails = {
                                "HotelName":"elizabeth",
                                "FromDate":arrivalDate,
                                "ToDate":departureDate,
                                "DistanceToLocation":2
                            };
        outResponse.setJsonPayload(hotelDetails);
        _ = connection.respond(outResponse);
    }
}
