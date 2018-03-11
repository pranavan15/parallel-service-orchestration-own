package TravelAgency.CarRental;

import ballerina.net.http;

@http:configuration {basePath:"/car", port:9093}
service<http> carRentalService {

    @http:resourceConfig {methods:["POST"], path:"/driveSg"}
    resource driveSg (http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        json receivedPayload = request.getJsonPayload();
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json vehicleType = receivedPayload.vehicleType;
        json vehicleDetails = {
                                  "Company":"DriveSG",
                                  "VehicleType":vehicleType,
                                  "From":from,
                                  "To":to,
                                  "price":50
                              };
        response.setJsonPayload(vehicleDetails);
        _ = connection.respond(response);
    }

    @http:resourceConfig {methods:["POST"], path:"/dreamCar"}
    resource dreamCar (http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        json receivedPayload = request.getJsonPayload();
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json vehicleType = receivedPayload.vehicleType;
        json vehicleDetails = {
                                  "Company":"DreamCar",
                                  "VehicleType":vehicleType,
                                  "From":from,
                                  "To":to,
                                  "price":60
                              };
        response.setJsonPayload(vehicleDetails);
        _ = connection.respond(response);
    }

    @http:resourceConfig {methods:["POST"], path:"/sixt"}
    resource sixT (http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        json receivedPayload = request.getJsonPayload();
        json from = receivedPayload.from;
        json to = receivedPayload.to;
        json vehicleType = receivedPayload.vehicleType;
        json vehicleDetails = {
                                  "Company":"SixT",
                                  "VehicleType":vehicleType,
                                  "From":from,
                                  "To":to,
                                  "price":65
                              };
        response.setJsonPayload(vehicleDetails);
        _ = connection.respond(response);
    }
}
