import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:proyek_ambw_kel15/models/APIModel.dart';

class APISerivce {
  //Base API Url
  static const String _baseUrl = "wft-geo-db.p.rapidapi.com";

  //Base headers for response url
  static final Map<String, String> _headers = {
    "content-type": "application/json",
    "X-Rapidapi-Host": "wft-geo-db.p.rapidapi.com",
    "x-Rapidapi-Key": dotenv.env['_api_key']!,
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

  Future<double> getDistanceBetweenCity({
    required String endpoint,
    required Map<String, String> query,
  }) async {
    Uri uri = Uri.https(_baseUrl, endpoint, query);
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final list = data['data'];
      return list;
    } else {
      throw response.statusCode;
    }
  }
}
