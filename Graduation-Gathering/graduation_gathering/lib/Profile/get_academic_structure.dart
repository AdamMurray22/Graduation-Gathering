import 'dart:convert';

import 'package:graduation_gathering/Profile/academic_structure.dart';

import '../AWS/send_request.dart';
import '../Auth/auth_token.dart';

class GetAcademicStructure extends SendRequest {

  Future<AcademicStructure> send(AuthToken token) async {
    Map<String, String> headers = {"Authorization": token.getToken()};
    String responseBody = await get(headers);
    Map<String, dynamic> responseJson = json.decode(
        responseBody);
    return AcademicStructure(responseJson);
  }

  @override
  getRoute() {
    return "getAcademicStructure";
  }
}