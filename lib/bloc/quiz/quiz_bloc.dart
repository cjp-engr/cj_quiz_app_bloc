import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:quiz_app/repositories/quiz_repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;
  QuizBloc({required this.quizRepository}) : super(QuizState.initial()) {
    on<LoadQuizEvent>(_loadQuizEvent);
    on<CheckAnswerEvent>(_checkAnswer);
    on<ClearDetailsEvent>(_clearDetails);
  }

  void _loadQuizEvent(
    LoadQuizEvent event,
    Emitter<QuizState> emit,
  ) async {
    emit(state.copyWith(quizStatus: QuizStatus.loading));
    List<Results>? results = await quizRepository.readJson();

    for (var item in results!) {
      item.incorrectanswers.add(item.correctAnswer);
      item.incorrectanswers.shuffle();
      List<String> q = [...state.question, item.question!];
      List<String> ca = [...state.correctAns, item.correctAnswer!];
      List<List<dynamic>> ci = [
        ...state.correctIncorrect,
        item.incorrectanswers
      ];
      List<String> sAns = [...state.selectedAns, ''];
      emit(state.copyWith(
        question: q,
        correctAns: ca,
        correctIncorrect: ci,
        selectedAns: sAns,
        quizStatus: QuizStatus.loaded,
      ));
    }
  }

  void _checkAnswer(
    CheckAnswerEvent event,
    Emitter<QuizState> emit,
  ) async {
    //log(event.index.toString());
    state.selectedAns[event.questionIndex] = event.selectedAnswer;
    if (state.correctAns[event.questionIndex] == event.selectedAnswer) {
      emit(state.copyWith(
        choiceIndex: event.choiceIndex,
        selectedAns: state.selectedAns,
        //totalCorrect: state.totalCorrect + 1,
        isCorrect: true,
      ));
      await Future.delayed(const Duration(seconds: 2));
      add(ClearDetailsEvent());
    } else {
      emit(state.copyWith(
        choiceIndex: event.choiceIndex,
        selectedAns: state.selectedAns,
        //totalIncorrect: state.totalIncorrect + 1,
        isCorrect: false,
      ));
      await Future.delayed(const Duration(seconds: 2));
      add(ClearDetailsEvent());
    }
  }

  void _clearDetails(
    ClearDetailsEvent event,
    Emitter<QuizState> emit,
  ) {
    emit(state.copyWith(
      choiceIndex: -1,
      selectedAns: state.selectedAns,
      isCorrect: false,
    ));
  }
}
