import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/quiz/quiz_bloc.dart';
import 'package:quiz_app/quiz_page.dart';
import 'package:quiz_app/repositories/quiz_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => QuizRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<QuizBloc>(
            create: (context) => QuizBloc(
              quizRepository: context.read<QuizRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: const TextTheme(
              headline6: TextStyle(
                fontSize: 26.5,
                fontWeight: FontWeight.w600,
              ),
              subtitle1: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w400,
              ),
            ).apply(
              fontFamily: 'Poppins',
            ),
          ),
          home: const QuizPage(),
        ),
      ),
    );
  }
}
