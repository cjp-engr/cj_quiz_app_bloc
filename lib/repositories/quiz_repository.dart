import 'dart:developer';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quiz_app/models/questions.dart';

class QuizRepository {
  Future<List<Results>?> readJson() async {
    final String response = await rootBundle.loadString('assets/quiz.json');
    final data = await json.decode(response);
    var _items = data['results'];
    try {
      List<Results> results =
          (_items as List).map((e) => Results.fromJson(e)).toList();
      return results;
    } catch (e) {
      log('try failed $e');
    }
    return null;
  }
}
