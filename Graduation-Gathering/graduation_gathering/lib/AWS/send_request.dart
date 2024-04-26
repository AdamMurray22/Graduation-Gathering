import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Sends a request to the server.
abstract class SendRequest {

  // Server URL as String object.
  final String _serverURL = "https://058sjjvnef.execute-api.eu-west-2.amazonaws.com/";

  // Combines the server URL and endpoint route into a URI object.
  Uri _getUri() {
    Uri uri = Uri.parse(_serverURL + getRoute());
    return uri;
  }

  /// Returns the route within the server to the endpoint.
  @protected
  getRoute();

  /// Sends a post request to the server.
  @protected
  Future<String> post(String body, {Map<String, String>? headers}) async {
    Uri uri = _getUri();
    http.Response response = await http.post(uri, headers: headers, body: body);
    return response.body;
  }

  /// Sends a get request to the server.
  @protected
  Future<String> get(Map<String, String>? headers) async {
    Uri uri = _getUri();
    http.Response response = await http.get(uri, headers: headers);
    return response.body;
  }
}