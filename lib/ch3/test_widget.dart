import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // 테마설정, Navigation 처리 ex) 칼라 설정
      home: Scaffold( // 화면 구조를 잡아줌.
        appBar: AppBar(
          title: Text('Hello World'),
        ),
        body: Center(child: GestureDetector(child: Text('Hello World'))),
        // GestureDetector : 화면과 관련된 이벤트 처리
      )
    );
  }
}