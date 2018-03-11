package TravelAgency;

import ballerina.net.http;

@http:configuration {basePath:"/web", port:9090}
service<http> HolidayPackage {

    @http:resourceConfig {
        methods:["GET"],
        path:"/holiday"
    }
    resource holidayPackage (http:Connection connection, http:InRequest request) {
        endpoint<http:HttpClient> httpEndpoint {
            create http:HttpClient("http://localhost:9090/", {});
        }

        http:OutResponse response = {};
        map params = request.getQueryParams();
        var departureDate, _ = (string)params.depart;
        var returnDate, _ = (string)params.returnDate;
        var from, _ = (string)params.from;
        var to, _ = (string)params.to;
        var vehicleType, _ = (string)params.vehicleType;
        var location, _ = (string)params.location;

        string flightPayload = string `{"departure":"{{departureDate}}", "returnDate":"{{returnDate}}",
        "from":"{{from}}", "to":"{{to}}"}`;
        string vehiclePayload = string `{"from":"{{departureDate}}", "to":"{{returnDate}}",
        "vehicleType":"{{vehicleType}}"}`;
        string hotelPayload = string `{"from":"{{departureDate}}", "to":"{{returnDate}}", "location":"{{location}}"}`;

        json jsonFlightResponse;
        json jsonVehicleResponse;
        json jsonHotelResponse;
        json miramarJsonResponse;
        json aqueenJsonResponse;
        json elizabethJsonResponse;
        json jsonFlightResponseEmirates;
        json jsonFlightResponseAsiana;
        json jsonFlightResponseQatar;

        fork {

            worker qatarWorker {
                var payload, _ = <json>flightPayload;
                http:OutRequest req = {};
                http:InResponse respWorkerQatar = {};
                req.setJsonPayload(payload);
                respWorkerQatar, _ = httpEndpoint.post("/airline/qatarAirways", req);
                respWorkerQatar -> fork;
            }

            worker asianaWorker {
                var payload, _ = <json>flightPayload;
                http:OutRequest req = {};
                http:InResponse respWorkerAsiana = {};
                req.setJsonPayload(payload);
                respWorkerAsiana, _ = httpEndpoint.post("/airline/asiana", req);
                respWorkerAsiana -> fork;
            }

            worker emiratesWorker {
                var payload, _ = <json>flightPayload;
                http:OutRequest req = {};
                http:InResponse respWorkerEmirates = {};
                req.setJsonPayload(payload);
                respWorkerEmirates, _ = httpEndpoint.post("/airline/emirates", req);
                respWorkerEmirates -> fork;
            }
        } join (all) (map airlineResponses) {
            // Wait until all the responses are received from the parallel running workers
            var qatarPrice = 0;
            var asianaPrice = 0;
            var emiratesPrice = 0;

            if (airlineResponses["qatarWorker"] != null) {
                var resQatarWorker, _ = (any[])airlineResponses["qatarWorker"];
                var responseQatar, _ = (http:InResponse)(resQatarWorker[0]);
                jsonFlightResponseQatar = responseQatar.getJsonPayload();
                qatarPrice, _ = (int)responseQatar.getJsonPayload().price;
            }

            if (airlineResponses["asianaWorker"] != null) {
                var resAsianaWorker, _ = (any[])airlineResponses["asianaWorker"];
                var responseAsiana, _ = (http:InResponse)(resAsianaWorker[0]);
                jsonFlightResponseAsiana = responseAsiana.getJsonPayload();
                asianaPrice, _ = (int)responseAsiana.getJsonPayload().price;
            }

            if (airlineResponses["emiratesWorker"] != null) {
                var resEmiratesWorker, _ = (any[])airlineResponses["emiratesWorker"];
                var responseEmirates, _ = ((http:InResponse)(resEmiratesWorker[0]));
                jsonFlightResponseEmirates = responseEmirates.getJsonPayload();
                emiratesPrice, _ = (int)responseEmirates.getJsonPayload().price;

            }

            if (qatarPrice < asianaPrice) {
                if (qatarPrice < emiratesPrice) {
                    jsonFlightResponse = jsonFlightResponseQatar;
                }
            } else {
                if (qatarPrice < emiratesPrice) {
                    jsonFlightResponse = jsonFlightResponseAsiana;
                }
                else {
                    jsonFlightResponse = jsonFlightResponseEmirates;
                }
            }
        }

        fork {

            worker driveSg {
                var payload, _ = <json>vehiclePayload;
                http:OutRequest req = {};
                http:InResponse respWorkerDriveSg = {};
                req.setJsonPayload(payload);
                respWorkerDriveSg, _ = httpEndpoint.post("/carRental/driveSg", req);
                respWorkerDriveSg -> fork;
            }

            worker dreamCar {
                var payload, _ = <json>vehiclePayload;
                http:OutRequest req = {};
                http:InResponse respWorkerDreamCar = {};
                req.setJsonPayload(payload);
                respWorkerDreamCar, _ = httpEndpoint.post("/carRental/dreamCar", req);
                respWorkerDreamCar -> fork;
            }

            worker sixt {
                var payload, _ = <json>vehiclePayload;
                http:OutRequest req = {};
                http:InResponse respWorkerSixt = {};
                req.setJsonPayload(payload);
                respWorkerSixt, _ = httpEndpoint.post("/carRental/sixt", req);
                respWorkerSixt -> fork;
            }
        } join (some 1) (map carResponses) {
            // Get the first responding worker
            if (carResponses["driveSg"] != null) {
                var resDriveSgWorker, _ = (any[])carResponses["driveSg"];
                var responseDriveSg, _ = (http:InResponse)(resDriveSgWorker[0]);
                jsonVehicleResponse = responseDriveSg.getJsonPayload();
            }

            else if (carResponses["dreamCar"] != null) {
                var resDreamCarWorker, _ = (any[])carResponses["dreamCar"];
                var responseDreamCar, _ = (http:InResponse)(resDreamCarWorker[0]);
                jsonVehicleResponse = responseDreamCar.getJsonPayload();
            }

            else if (carResponses["sixt"] != null) {
                var resSixtWorker, _ = (any[])carResponses["sixt"];
                var responseSixt, _ = ((http:InResponse)(resSixtWorker[0]));
                jsonVehicleResponse = responseSixt.getJsonPayload();
            }
        }

        fork {

            worker miramar {
                var payload, _ = <json>hotelPayload;
                http:OutRequest req = {};
                http:InResponse respWorkerMiramar = {};
                req.setJsonPayload(payload);
                respWorkerMiramar, _ = httpEndpoint.post("/hotel/miramar", req);
                respWorkerMiramar -> fork;
            }

            worker aqueen {
                var payload, _ = <json>hotelPayload;
                http:OutRequest req = {};
                http:InResponse respWorkerAqueen = {};
                req.setJsonPayload(payload);
                respWorkerAqueen, _ = httpEndpoint.post("/hotel/aqueen", req);
                respWorkerAqueen -> fork;
            }

            worker elizabeth {
                var payload, _ = <json>hotelPayload;
                http:OutRequest req = {};
                http:InResponse respWorkerElizabeth = {};
                req.setJsonPayload(payload);
                respWorkerElizabeth, _ = httpEndpoint.post("/hotel/elizabeth", req);
                respWorkerElizabeth -> fork;
            }
        } join (all) (map hotelResponses) {
            // Wait until all the responses are received from the parallely running workers
            var miramarDistance = 0;
            var aqueenDistance = 0;
            var elizabethDistance = 0;

            if (hotelResponses["miramar"] != null) {
                var resMiramarWorker, _ = (any[])hotelResponses["miramar"];
                var responseMiramar, _ = (http:InResponse)(resMiramarWorker[0]);
                miramarJsonResponse = responseMiramar.getJsonPayload();
                miramarDistance, _ = (int)responseMiramar.getJsonPayload().DistanceToLocation;
            }

            if (hotelResponses["aqueen"] != null) {
                var resAqueenWorker, _ = (any[])hotelResponses["aqueen"];
                var responseAqueen, _ = (http:InResponse)(resAqueenWorker[0]);
                aqueenJsonResponse = responseAqueen.getJsonPayload();
                aqueenDistance, _ = (int)responseAqueen.getJsonPayload().DistanceToLocation;
            }

            if (hotelResponses["elizabeth"] != null) {
                var resElizabethWorker, _ = (any[])hotelResponses["elizabeth"];
                var responseElizabeth, _ = ((http:InResponse)(resElizabethWorker[0]));
                elizabethJsonResponse = responseElizabeth.getJsonPayload();
                elizabethDistance, _ = (int)responseElizabeth.getJsonPayload().DistanceToLocation;
            }

            if (miramarDistance < aqueenDistance) {
                if (miramarDistance < elizabethDistance) {
                    jsonHotelResponse = miramarJsonResponse;
                }
            } else {
                if (aqueenDistance < elizabethDistance) {
                    jsonHotelResponse = aqueenJsonResponse;
                }
                else {
                    jsonHotelResponse = elizabethJsonResponse;
                }
            }
        }

        json clientResponse = {
                                  "Flight":
                                  {
                                      "Company":jsonFlightResponse.Flight,
                                      "Departure Date":jsonFlightResponse.DepartureDate,
                                      "From":jsonFlightResponse.From,
                                      "To":jsonFlightResponse.To,
                                      "Price":jsonFlightResponse.price
                                  },
                                  "Vehicle":
                                  {
                                      "Company":jsonVehicleResponse.Company,
                                      "VehicleType":jsonVehicleResponse.VehicleType,
                                      "Price per Day($)":jsonVehicleResponse.price
                                  },
                                  "Hotel":
                                  {
                                      "Hotel":jsonHotelResponse.Hotel,
                                      "From Date":jsonHotelResponse.From,
                                      "To Date":jsonHotelResponse.To,
                                      "Distance to Location(Miles)":jsonHotelResponse.DistanceToLocation
                                  }
                              };

        response.setJsonPayload(clientResponse);
        _ = connection.respond(response);
    }
}
