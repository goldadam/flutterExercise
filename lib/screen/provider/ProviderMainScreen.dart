import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './HomeTodoScreen.dart';
import '../../provider/TodosModel.dart';

class ProviderMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 공통의 조상 역할을 하는 위젯에서 provider 데이터 등록..

    return ChangeNotifierProvider(
      create: (context) => TodosModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // 디버그 띠가 사라짐.
        home: HomeScreen(),
      ),
    );
  }
}
