import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class SendRequest {

  @protected
  String serverURL = "";

  @protected
  Future<String> post(String body) async {
    Uri uri = _getUri();
    http.Response response = await http.post(uri, body: body);
    return response.body;
  }

  Uri _getUri() {
    Uri uri = Uri.parse(serverURL);
    return uri;
  }

  @protected
  setServerURL();
}