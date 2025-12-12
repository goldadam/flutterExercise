import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/TodoBloc.dart';
import 'HomeTodoScreen.dart';

class BlocMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodosBloc>(
      create: (context) => TodosBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // 디버그 띠 제거
        home: HomeScreen(),
      ),
    );
  }
}
