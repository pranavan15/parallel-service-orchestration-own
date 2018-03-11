package TravelAgency.HotelReservation;

import ballerina.net.http;

@http:configuration {basePath:"/hotel", port:9092}
service<http> HotelService {

    @http:resourceConfig {methods:["POST"], path:"/miramar"}
    resource miramar (http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        json receivedPayload = request.getJsonPayload();
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json hotelDetails = {
                                "Hotel":"miramar",
                                "From":from,
                                "To":to,
                                "DistanceToLocation":10
                            };
        response.setJsonPayload(hotelDetails);
        _ = connection.respond(response);
    }

    @http:resourceConfig {methods:["POST"], path:"/aqueen"}
    resource aqueen (http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        json receivedPayload = request.getJsonPayload();
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json hotelDetails = {
                                "Hotel":"aqueen",
                                "From":from,
                                "To":to,
                                "DistanceToLocation":8
                            };
        response.setJsonPayload(hotelDetails);
        _ = connection.respond(response);
    }

    @http:resourceConfig {methods:["POST"], path:"/elizabeth"}
    resource elizabeth (http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        json receivedPayload = request.getJsonPayload();
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json hotelDetails = {
                                "Hotel":"elizabeth",
                                "From":from,
                                "To":to,
                                "DistanceToLocation":5
                            };
        response.setJsonPayload(hotelDetails);
        _ = connection.respond(response);
    }
}
