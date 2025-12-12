// material.dart - 구글의 material design에 입각해서 준비된 위젯을 제공
// 원한다면 cupertino(ios 스타일의 위젯)을 import 해서 작성도 가능..
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

// 위젯 트리의 루트 역할을 하는 개발자 위젯은 일반적으로 stateless로 선언한다..
// stateful 로 선언이 가능하기는 하지만... 그렇게 되면 화면 갱신시에 너무 많은 위젯 객체가 다시 생성될 수 있고..
// 성능에 문제가 될 수 있다 (권장하지 않음)
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // 개발자 화면 단위 위젯의 루트는 일반적으로 MaterialApp(테마, 라우팅)
    return MaterialApp(
      // named parameter(생성자 매개변수)
      // 화면의 기본 구조를 제공하는 위젯,,
      home: Scaffold(
        appBar: AppBar(title: Text("Widget Test"), backgroundColor: Colors.red,),
        body: Column(
          children: [
            MyStatelessWidget(),
            MyStatefulWidget(),
          ],
        ),
      ),

    );
  }
}


class MyStatelessWidget extends StatelessWidget{
  // StatelessWidget은 상태를 유지하지 못한다는 것이지, 변수를 선언하지 못한다는 것이 아니다..
  bool favorited = false;
  int favoritedCount = 10;

  void toggleFavorate(){
    print("Stateless... toggleFavorate");
    if(favorited){
      favorited = false;
      favoritedCount--;
    }else{
      favorited = true;
      favoritedCount++;
    }
  }

  // Stateless Widget
  @override
  Widget build(BuildContext context) {
    print("statelessWidget... build Called");
    return Row(
      children: [
        IconButton(
            onPressed: toggleFavorate, // 이벤트 call back 함수로 작동가능하도록.
            icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red,
        ),
        Text('$favoritedCount')
      ],
    );
  }
}

// ----------------------------------
// Stateful Widget
class MyStatefulWidget extends StatefulWidget{

  // StatefulWidget의 State 객체를 지정하기 위해 자동 호출...
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}
// statefulwidget은 state와 statefulWidget의 조합으로 사용해야 함.
class MyState extends State<MyStatefulWidget> {

  bool favorited = false;
  int favoritedCount = 10;

  void toggleFavorate(){
    print("Stateful... toggleFavorate");
    // state의 변수가 변경되었다고.. 화면이 갱신되는 것이 아니라.. 화면 갱신 명령을 setStatus()로 잡아줘야 함..
    // setState()의 매개변수에 지정한 함수가 먼저 호출이 되고.. 그 함수의 호출이 끝나면 화면 갱신이 된다..
    // 화면 갱신하기 전에.. 값 변경은 setState()의 매개변수 함수에서 하는 것이 좋다....
    // 화면 갱신부터 비동기로 인식함. 개발자의 값이 변경되었어도 그 전에 화면 갱신을 해버리면 값 변경된 점이 인지되지 않을 수 있음.
    setState(() {
      if(favorited){
        favorited = false;
        favoritedCount--;
      }else{
        favorited = true;
        favoritedCount++;
      }
    });

  }

  // Stateless Widget
  @override
  Widget build(BuildContext context) {
    print("statefulWidget... build Called");
    return Row(
      children: [
        IconButton(
          onPressed: toggleFavorate, // 이벤트 call back 함수로 작동가능하도록.
          icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border)),
          color: Colors.red,
        ),
        Text('$favoritedCount')
      ],
    );
  }
}

