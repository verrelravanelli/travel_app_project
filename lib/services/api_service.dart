import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:proyek_ambw_kel15/models/APIModel.dart';

class APISerivce {
  //API KEY
  static const _api_key = 'c2dc4dac0amshbac09264c8d4eb0p1bdfc9jsn1a1122013758';

  //Base API Url
  static const String _baseUrl = "wft-geo-db.p.rapidapi.com";

  //Base headers for response url
  static const Map<String, String> _headers = {
    "content-type": "application/json",
    "X-Rapidapi-Host": "wft-geo-db.p.rapidapi.com",
    "x-Rapidapi-Key": _api_key,
  };

  Future<List<APIModel>> get({
    required String endpoint,
    required Map<String, String> query,
  }) async {
    Uri uri = Uri.https(_baseUrl, endpoint, query);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final list = data['data'];

      List<APIModel> getAllData = list.map<APIModel>((json) => APIModel.fromJson(json)).toList();

      return getAllData;
    } else {
      throw response.statusCode;
    }
  }
  // Future<APIModel> get({
  //   required String endpoint,
  //   required Map<String, String> query,
  // }) async {
  //   Uri uri = Uri.https(_baseUrl, endpoint, query);
  //   final response = await http.get(uri, headers: _headers);
  //   if (response.statusCode == 200) {
  //     // If server returns an OK response, parse the JSON.
  //     final data = json.decode(response.body);
  //     final list = data['data'][0];
  //     print(list);

  //     APIModel getAllData =
  //     list.map<APIModel>((json) => APIModel.fromJson(json)).toList();

  //     print(getAllData.wikiDataId);
  //     return getAllData;
  //   } else {
  //     print("EROR");
  //     throw response.statusCode;
  //   }
  // }

  Future<double> getDistanceBetweenCity({
    required String endpoint,
    required Map<String, String> query,
  }) async {
    Uri uri = Uri.https(_baseUrl, endpoint, query);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log(data.toString());
      final list = data['data'];
      return list;
    } else {
      throw response.statusCode;
    }
  }
}
