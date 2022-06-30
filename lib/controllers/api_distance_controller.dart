import 'package:get/get.dart';

import '../models/APIModel.dart';
import '../services/api_service.dart';

class APIDistanceController extends GetxController {
  var userlocationid = "";
  var destinationid = "";
  var destinationcity = "";
  var userCity = "";
  double distance = 0.0;

  List<APIModel> tempDataAPI = [];

  void ambilDataAPIDistance() async {
    APISerivce apiService = APISerivce();
    Future<double> dtAPI;
    dtAPI = apiService.getDistanceBetweenCity(
      endpoint: '/v1/geo/cities/${userlocationid}/distance',
      query: {
        "distanceUnit": "KM",
        "toCityId": tempDataAPI[0].wikiDataId,
      },
    );
    distance = await dtAPI;
    print("Distance : $distance");
  }

  void ambilDataAPI() async {
    print("Kota Destinasi : $destinationcity");
    print("ID Kota Destinasi : $destinationid");
    APISerivce apiService = APISerivce();
    Future<List<APIModel>> cityID;
    cityID = apiService.get(
      endpoint: '/v1/geo/cities',
      query: {
        "limit": "${1}",
        "countryIds": destinationid,
        "namePrefix": destinationcity,
        "types": "CITY",
      },
    );
    tempDataAPI = await cityID;
  }
}
