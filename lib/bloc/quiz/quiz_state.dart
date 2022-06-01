part of 'quiz_bloc.dart';

enum QuizStatus { initial, loading, loaded, error }

class QuizState extends Equatable {
  final List<String> question;
  final QuizStatus quizStatus;
  final List<List<dynamic>> correctIncorrect;
  final List<String> correctAns;
  final bool isCorrect;
  final List<String> selectedAns;
  final int choiceIndex;
  // final int totalIncorrect;
  // final int totalCorrect;
  const QuizState({
    required this.question,
    required this.quizStatus,
    required this.correctIncorrect,
    required this.correctAns,
    required this.isCorrect,
    required this.selectedAns,
    required this.choiceIndex,
    // required this.totalIncorrect,
    // required this.totalCorrect,
  });

  factory QuizState.initial() {
    return const QuizState(
      question: [],
      quizStatus: QuizStatus.initial,
      correctIncorrect: [],
      correctAns: [],
      isCorrect: false,
      selectedAns: [],
      choiceIndex: -1,
      // totalIncorrect: 0,
      // totalCorrect: 0,
    );
  }

  @override
  List<Object?> get props => [
        question,
        quizStatus,
        correctIncorrect,
        correctAns,
        isCorrect,
        selectedAns,
        choiceIndex,
        // totalIncorrect,
        // totalCorrect,
      ];

  QuizState copyWith({
    List<String>? question,
    QuizStatus? quizStatus,
    List<List<dynamic>>? correctIncorrect,
    List<String>? correctAns,
    bool? isCorrect,
    List<String>? selectedAns,
    int? choiceIndex,
  }) {
    return QuizState(
      question: question ?? this.question,
      quizStatus: quizStatus ?? this.quizStatus,
      correctIncorrect: correctIncorrect ?? this.correctIncorrect,
      correctAns: correctAns ?? this.correctAns,
      isCorrect: isCorrect ?? this.isCorrect,
      selectedAns: selectedAns ?? this.selectedAns,
      choiceIndex: choiceIndex ?? this.choiceIndex,
    );
  }

  @override
  String toString() {
    return 'QuizState(question: $question, quizStatus: $quizStatus, correctIncorrect: $correctIncorrect, correctAns: $correctAns, isCorrect: $isCorrect, selectedAns: $selectedAns, choiceIndex: $choiceIndex)';
  }
}
