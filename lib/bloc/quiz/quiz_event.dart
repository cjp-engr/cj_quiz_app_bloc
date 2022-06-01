part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class LoadQuizEvent extends QuizEvent {}

class CheckAnswerEvent extends QuizEvent {
  final String selectedAnswer;
  final int questionIndex;
  final int choiceIndex;

  const CheckAnswerEvent({
    required this.selectedAnswer,
    required this.questionIndex,
    required this.choiceIndex,
  });
}

class ClearDetailsEvent extends QuizEvent {}
