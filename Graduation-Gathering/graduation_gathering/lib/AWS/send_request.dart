import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class SendRequest {

  final String _serverURL = "https://058sjjvnef.execute-api.eu-west-2.amazonaws.com/";

  Uri _getUri() {
    Uri uri = Uri.parse(_serverURL + getRoute());
    return uri;
  }

  @protected
  getRoute();

  @protected
  Future<String> post(String body) async {
    Uri uri = _getUri();
    http.Response response = await http.post(uri, body: body);
    return response.body;
  }

  @protected
  Future<String> get(Map<String, String>? headers) async {
    Uri uri = _getUri();
    http.Response response = await http.get(uri, headers: headers);
    return response.body;
  }
}