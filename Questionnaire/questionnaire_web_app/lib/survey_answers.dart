class SurveyAnswers {
  late final String? _q1;
  final List<String> _q2;
  final List<String> _q3;
  final String _q4;

  SurveyAnswers(q1, this._q2, this._q3, this._q4) {
    if (q1[0] == true) {
      _q1 = "Student";
    } else if (q1[1] == true) {
      _q1 = "Staff";
    } else if (q1[2] == true) {
      _q1 = "Prefer Not to Say";
    } else {
      _q1 = null;
    }
  }

  dynamic getAnswersAsJson() {
    return {"Q1": _q1, "Q2": _q2, "Q3": _q3, "Q4": _q4};
  }

  bool answersValid() {
    return _q1 != null;
  }
}
