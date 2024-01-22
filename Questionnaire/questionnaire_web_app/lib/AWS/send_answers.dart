import 'dart:convert';

import '../survey_answers.dart';
import 'package:http/http.dart' as http;

class SendAnswers {
  final String _serverURL =
      "https://9ks41n242k.execute-api.eu-west-2.amazonaws.com/prod/addQuestionnaireResults";

  send(SurveyAnswers answers) {
    dynamic bodyJson = answers.getAnswersAsJson();
    String body = json.encode(bodyJson);
    _post(body);
  }

  Future<String> _post(String body) async {
    Uri uri = _getUri();
    http.Response response = await http.post(uri, body: body);
    return response.body;
  }

  Uri _getUri() {
    Uri uri = Uri.parse(_serverURL);
    return uri;
  }
}
