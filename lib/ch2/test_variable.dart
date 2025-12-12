import 'dart:collection';

main(){
  // 다트의 모든 변수는 객체이다

  int data1 = 10;
  print(data1.isEven);

  // 객체이므로 ..-> 기초타입 캐스팅이 되지 않는다.
  // double data2 = data1; -> error
  // int data3 = 10.0; --> error

  double data2 = data1.toDouble();
  print(data2);

  // String <-> int

  String data4 = "10";
  print(int.parse(data4));


  // var .. dynamic
  // var : type이 없는 것이 아니라 선언시 해당 타입으로 고정된다.
  int a = 10;
  var b = 10;
  print(b);
   // b = "hello"; error

  dynamic c = 10;
  c = 'hello';
  print(c);
  c = true;
  print(c);

  // var 선언시 값을 주지 않으면 dynamic type으로 유추된다.
  var d;
  d = 10;
  d = 'hello';
  d = true;


  //List..
  List<int> list1 = [10,20,30];
  list1.add(40);
  print(list1);
  print(list1[0]);

  // List 사이즈 지정 후 사용
  /*List<int> list2 = List.filled(2, 10); // 런타임 error 발생 :
  print(list2);
  list2.add(90);
  // list2.add(80);
  list2[0] = 12;
  // list2.add(40); // 오류 발생. cannot add to a fixed-length list (max length보다 큰것을 insert 하기 위해서 하기와 같이 오류 발생)
  */

  Map<String, String> map = {
    "h": "1",
    "t" : "2"
  };
  print(map["t"]);

  String? k = "hello";
  k = null;


  User user2 = new User();
  print(user2.a1);
  print(user2.a2);

  int? a1 = 20;
  a1!; // 런타임 시점에서 a1이 null이면 exception을 발생시켜라



}

class User{
  String? a1;
  String? a2;

}