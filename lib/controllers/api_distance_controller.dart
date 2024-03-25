import 'package:get/get.dart';

import '../models/APIModel.dart';
import '../services/api_service.dart';

class APIDistanceController extends GetxController {
  var userlocationid = "";
  var destinationid = "";
  var destinationcity = "";
  var userCity = "";
  var kotabaru = "";
  double distance = 0.0;

  List<APIModel> tempDataAPI = [];
  List<APIModel> tempDataAPIEditProfile = [];

  void ambilDataAPIDistance() async {
    APISerivce apiService = APISerivce();
    Future<double> dtAPI;
    dtAPI = apiService.getDistanceBetweenCity(
      endpoint: '/v1/geo/cities/$userlocationid/distance',
      query: {
        "distanceUnit": "KM",
        "toCityId": tempDataAPI[0].wikiDataId,
      },
    );
    distance = await dtAPI;
  }

  void ambilDataAPI() async {
    APISerivce apiService = APISerivce();
    List<APIModel> cityID = await apiService.get(
      endpoint: '/v1/geo/cities',
      query: {
        "limit": "${1}",
        "countryIds": destinationid,
        "namePrefix": destinationcity,
        "types": "CITY",
      },
    );
    tempDataAPI = cityID;
  }

  void ambilDataAPIEditProfile() async {
    APISerivce apiService = APISerivce();
    List<APIModel> cityID = await apiService.get(
      endpoint: '/v1/geo/cities',
      query: {
        "limit": "${1}",
        "countryIds": "ID",
        "namePrefix": kotabaru,
        "types": "CITY",
      },
    );
    tempDataAPIEditProfile = cityID;
  }
}
