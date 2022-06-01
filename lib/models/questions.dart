class Results {
  String? question;
  String? correctAnswer;
  List<dynamic> incorrectanswers;

  Results({this.question, this.correctAnswer, required this.incorrectanswers});

  Results.fromJson(Map<String, dynamic> mapOfJson)
      : question = mapOfJson["question"],
        correctAnswer = mapOfJson["correct_answer"],
        incorrectanswers = mapOfJson["incorrect_answers"];
}
