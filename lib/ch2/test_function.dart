// import 'package:flutter_lab/ch2/test1.dart';
//
// main(){
//   // named parameter : {}로 묶인 함수는  optional
//   // optional 로 매개변수를 선언하면 .. 호출시에 값이 대입되지 않을 수 있다.
//   // 따라서 nullable로 선언해야 하거나 / default 값을 설정해야 한다.
//
//   void myFunc1(bool data1, {String? data2, int? data3}){
//
//   }
//
//   myFunc1(true); // ok
//   myFunc1(true, data2: 'hello', data3: 100); // error .. named parameter로 선언된 매개변수에 대해 값을 지정하려면 꼭 이름을 명시해야 한다.
//   myFunc1(true, data2:'t');
//   // 이름이 명시되므로 매개변수의 순서는 의미가 없다.
//
//
//
//   // positional parameter
//   // nullable로 선언하던가 , 기본값을 명시해야 한다.
//   void myFunc2(bool data1, [ String? data2, int data3 = 0]){
//
//   }
// /*
//
//   //이용자 입장
//   myFunc2(true);
//   myFunc2(true, data2: 'hello', data3: 100); // error : positional parameter로 선언되어있기 때문에 값을 줄 수 없음
//   myFunc2(true, 100, 'hello'); // error : 순서를 반드시 지켜야 함
//   myFunc2(true, 'hello', 100); // ok
// */
//
//   // haf.............
//   int some(int no){
//     return no * 10;
//   }
//
//   Function myFunc3(int Function(int a) argFun){
//     print(argFun(10));
//     return some;
//
//   }
//
//   var result = myFunc3((int arg) => arg + 10);
//   print(result);
//
//
//   String _name = 'Hello';
//
//   String get name{
//     return _name.toUpperCase();
//   }
//   set name(value){
//     _name = value;
//   }
//
//
//
// }