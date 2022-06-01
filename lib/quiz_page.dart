import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/quiz/quiz_bloc.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final controller = PageController(initialPage: 0);
  @override
  void initState() {
    initialLoadQuiz();
    super.initState();
  }

  void initialLoadQuiz() {
    context.read<QuizBloc>().add(LoadQuizEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          return PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            itemCount: state.question.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      state.question[index],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Column(
                    children: [
                      for (int i = 0; i < 4; i++)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: state.correctIncorrect[index][i]
                                        .toString() ==
                                    ""
                                ? Container()
                                : ElevatedButton(
                                    onPressed: () async {
                                      context.read<QuizBloc>().add(
                                            CheckAnswerEvent(
                                              selectedAnswer: state
                                                  .correctIncorrect[index][i]
                                                  .toString(),
                                              questionIndex: index,
                                              choiceIndex: i,
                                            ),
                                          );
                                      await Future.delayed(
                                          const Duration(seconds: 2));
                                      controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn);
                                    },
                                    style: state.choiceIndex == i
                                        ? ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.red),
                                          )
                                        : ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: const BorderSide(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blue),
                                          ),
                                    child: Text(
                                      state.correctIncorrect[index][i]
                                          .toString(),
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state.selectedAns[index] == ''
                      ? const Text('')
                      : state.isCorrect
                          ? Column(
                              children: [
                                Text(
                                  'You got it right.',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Text(
                                  'You got it wrong.',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  'Correct answer: ' + state.correctAns[index],
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
