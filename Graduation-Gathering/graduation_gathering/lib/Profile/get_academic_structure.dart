import 'dart:convert';

import 'package:graduation_gathering/Profile/academic_structure.dart';

import '../AWS/send_request.dart';
import '../Auth/auth_token.dart';

/// Sends requests to the server to get the academic structure.
class GetAcademicStructure extends SendRequest {

  /// Sends the request and retrieves the academic structure.
  Future<AcademicStructure> send(AuthToken token) async {
    Map<String, String> headers = {"Authorization": token.getToken()};
    String responseBody = await get(headers);
    Map<String, dynamic> responseJson = json.decode(
        responseBody);
    return AcademicStructure(responseJson);
  }

  /// Returns the route within the server to the getAcademicStructure endpoint.
  @override
  getRoute() {
    return "getAcademicStructure";
  }
}