package TravelAgency.CarRental;

import ballerina.net.http;

@http:configuration {basePath:"/car", port:9093}
service<http> carRentalService {

    @http:resourceConfig {methods:["POST"], path:"/driveSg", consumes:["application/json"],
                          produces:["application/json"]}
    resource driveSg (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json vehicleType = receivedPayload.vehicleType;

        if (from == null || to == null || vehicleType == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json vehicleDetails = {
                                  "Company":"DriveSG",
                                  "VehicleType":vehicleType,
                                  "From":from,
                                  "To":to,
                                  "price":50
                              };
        outResponse.setJsonPayload(vehicleDetails);
        _ = connection.respond(outResponse);
    }

    @http:resourceConfig {methods:["POST"], path:"/dreamCar", consumes:["application/json"],
                          produces:["application/json"]}
    resource dreamCar (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json vehicleType = receivedPayload.vehicleType;

        if (from == null || to == null || vehicleType == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json vehicleDetails = {
                                  "Company":"DreamCar",
                                  "VehicleType":vehicleType,
                                  "From":from,
                                  "To":to,
                                  "price":60
                              };
        outResponse.setJsonPayload(vehicleDetails);
        _ = connection.respond(outResponse);
    }

    @http:resourceConfig {methods:["POST"], path:"/sixt", consumes:["application/json"], produces:["application/json"]}
    resource sixT (http:Connection connection, http:InRequest inRequest) {
        http:OutResponse outResponse = {};
        json receivedPayload = inRequest.getJsonPayload();
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json vehicleType = receivedPayload.vehicleType;

        if (from == null || to == null || vehicleType == null) {
            outResponse.statusCode = 400;
            outResponse.setJsonPayload({"Message":"Bad Request - Invalid Payload"});
            _ = connection.respond(outResponse);
            return;
        }

        json vehicleDetails = {
                                  "Company":"SixT",
                                  "VehicleType":vehicleType,
                                  "From":from,
                                  "To":to,
                                  "price":65
                              };
        outResponse.setJsonPayload(vehicleDetails);
        _ = connection.respond(outResponse);
    }
}
