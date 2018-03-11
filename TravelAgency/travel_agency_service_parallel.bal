package TravelAgency;

import ballerina.net.http;

@http:configuration {basePath:"/travel", port:9090}
service<http> travelAgencyService {

    // Endpoint to communicate with Airline reservation service
    endpoint<http:HttpClient> airlineReservationEP {
        create http:HttpClient("http://localhost:9091/airline", {});
    }

    // Endpoint to communicate with Hotel reservation service
    endpoint<http:HttpClient> hotelReservationEP {
        create http:HttpClient("http://localhost:9092/hotel", {});
    }

    // Endpoint to communicate with Car rental service
    endpoint<http:HttpClient> carRentalEP {
        create http:HttpClient("http://localhost:9093/car", {});
    }

    @http:resourceConfig {methods:["POST"]}
    resource arrangeTour (http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        json inReqPayload = request.getJsonPayload();

        json departureDate = inReqPayload.depart;
        json returnDate = inReqPayload.returnDate;
        json from = inReqPayload.from;
        json to = inReqPayload.to;
        json vehicleType = inReqPayload.vehicleType;
        json location = inReqPayload.location;

        json flightPayload = {"departure":departureDate, "returnDate":returnDate, "from":from, "to":to};
        json hotelPayload = {"from":departureDate, "to":returnDate, "location":location};
        json vehiclePayload = {"from":departureDate, "to":returnDate, "vehicleType":vehicleType};

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
                http:OutRequest req = {};
                http:InResponse respWorkerQatar = {};
                req.setJsonPayload(flightPayload);
                respWorkerQatar, _ = airlineReservationEP.post("/qatarAirways", req);
                respWorkerQatar -> fork;
            }

            worker asianaWorker {
                http:OutRequest req = {};
                http:InResponse respWorkerAsiana = {};
                req.setJsonPayload(flightPayload);
                respWorkerAsiana, _ = airlineReservationEP.post("/asiana", req);
                respWorkerAsiana -> fork;
            }

            worker emiratesWorker {
                http:OutRequest req = {};
                http:InResponse respWorkerEmirates = {};
                req.setJsonPayload(flightPayload);
                respWorkerEmirates, _ = airlineReservationEP.post("/emirates", req);
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

            worker miramar {
                http:OutRequest req = {};
                http:InResponse respWorkerMiramar = {};
                req.setJsonPayload(hotelPayload);
                respWorkerMiramar, _ = hotelReservationEP.post("/miramar", req);
                respWorkerMiramar -> fork;
            }

            worker aqueen {
                http:OutRequest req = {};
                http:InResponse respWorkerAqueen = {};
                req.setJsonPayload(hotelPayload);
                respWorkerAqueen, _ = hotelReservationEP.post("/aqueen", req);
                respWorkerAqueen -> fork;
            }

            worker elizabeth {
                http:OutRequest req = {};
                http:InResponse respWorkerElizabeth = {};
                req.setJsonPayload(hotelPayload);
                respWorkerElizabeth, _ = hotelReservationEP.post("/elizabeth", req);
                respWorkerElizabeth -> fork;
            }
        } join (all) (map hotelResponses) {
            // Wait until all the responses are received from the parallel running workers
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

        fork {

            worker driveSg {
                http:OutRequest req = {};
                http:InResponse respWorkerDriveSg = {};
                req.setJsonPayload(vehiclePayload);
                respWorkerDriveSg, _ = carRentalEP.post("/driveSg", req);
                respWorkerDriveSg -> fork;
            }

            worker dreamCar {
                http:OutRequest req = {};
                http:InResponse respWorkerDreamCar = {};
                req.setJsonPayload(vehiclePayload);
                respWorkerDreamCar, _ = carRentalEP.post("/dreamCar", req);
                respWorkerDreamCar -> fork;
            }

            worker sixt {
                http:OutRequest req = {};
                http:InResponse respWorkerSixt = {};
                req.setJsonPayload(vehiclePayload);
                respWorkerSixt, _ = carRentalEP.post("/sixt", req);
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
