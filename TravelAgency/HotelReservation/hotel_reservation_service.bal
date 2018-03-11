package TravelAgency.HotelReservation;

import ballerina.net.http;

@http:configuration {basePath:"/hotel", port:9092}
service<http> hotelReservationService {

    @http:resourceConfig {methods:["POST"], path:"/miramar", consumes:["application/json"],
                          produces:["application/json"]}
    resource miramar (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json location = receivedPayload.location;

        if (from == null || to == null || location == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json hotelDetails = {
                                "Hotel":"miramar",
                                "From":from,
                                "To":to,
                                "DistanceToLocation":10
                            };
        outResponse.setJsonPayload(hotelDetails);
        _ = connection.respond(outResponse);
    }

    @http:resourceConfig {methods:["POST"], path:"/aqueen", consumes:["application/json"],
                          produces:["application/json"]}
    resource aqueen (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json location = receivedPayload.location;

        if (from == null || to == null || location == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json hotelDetails = {
                                "Hotel":"aqueen",
                                "From":from,
                                "To":to,
                                "DistanceToLocation":8
                            };
        outResponse.setJsonPayload(hotelDetails);
        _ = connection.respond(outResponse);
    }

    @http:resourceConfig {methods:["POST"], path:"/elizabeth", consumes:["application/json"],
                          produces:["application/json"]}
    resource elizabeth (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json location = receivedPayload.location;

        if (from == null || to == null || location == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json hotelDetails = {
                                "Hotel":"elizabeth",
                                "From":from,
                                "To":to,
                                "DistanceToLocation":5
                            };
        outResponse.setJsonPayload(hotelDetails);
        _ = connection.respond(outResponse);
    }
}
