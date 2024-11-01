import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:laundry_management_mobile/constants/network_constants.dart';
import 'package:laundry_management_mobile/services/base/app_exceptions.dart';

class BaseClient {
  var client = http.Client();

  // get method
  Future<dynamic> get(String api) async {}
  // post method
  Future<dynamic> post(String api, dynamic object, {dynamic header}) async {
    var payload = jsonEncode(object);
    var uri = Uri.parse(NetworkConstants.baseURL + api);

    try {
      var response = await client.post(uri, body: payload, headers: header);
      return response;
    } catch (e) {
      debugPrint("BaseClient post error: $e");
      throw FetchDataException("No Internet connection", uri.toString());
    }
  }

  // put method
  Future<dynamic> put(String api) async {}
}