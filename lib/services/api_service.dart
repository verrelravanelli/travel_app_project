import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyek_ambw_kel15/models/APIModel.dart';

class APISerivce {
  //API KEY
  static const _api_key = 'a3cf9945d8msh6ac08f461f0bdd3p153e93jsne2cfb808dee7';

  //Base API Url
  static const String _baseUrl = "wft-geo-db.p.rapidapi.com";

  //Base headers for response url
  static const Map<String, String> _headers = {
    "content-type": "application/json",
    "X-Rapidapi-Host": "wft-geo-db.p.rapidapi.com",
    "x-Rapidapi-Key": _api_key,
  };

  // Base API request to get response
  Future<List<APIModel>> get({
    required String endpoint,
    required Map<String, String> query,
  }) async {
    Uri uri = Uri.https(_baseUrl, endpoint, query);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      final data = json.decode(response.body);
      final list = data['data'];

      List<APIModel> getAllData =
          list.map<APIModel>((json) => APIModel.fromJson(json)).toList();

      for (var i = 0; i < 1; i++) {
        print(getAllData[i].wikiDataId);
      }
      return getAllData;
    } else {
      throw response.statusCode;
    }
  }
}
