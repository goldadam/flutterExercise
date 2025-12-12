import 'package:flutter/cupertino.dart';

class User{
  String? name;
  int? age;
  //case 1. 생성자 매개변수로 멤버 초기화
  // java style, 보일러 플레이트 코드가 많아짐.
  // User(String name, int age){
  //   this.name = name;
  //   this.age = age;
  // }

  // case 2.
  /*User(this.name, this.age);*/

  // case 3. 매개변수를 참조해서 약간의 로직을 실행 후 멤버 초기화
  User(String name, int age): this.name = name.toUpperCase(), this.age  = age * 2;

  // 생성자 오버로딩은 지원하지 않음.
  // 여러 생성자를 선언하겠다면.. 이름을 추가해서 named constructor를 사용해라.
  User.one(){}
  // 생성자에서 다른 생성자를 호출하는 구문은 initialize 영역에..
  User.two(String name) : this.one();

}

// 이 클래스는 단 하나의 객체만 생성되어 이용을 강제하고 싶음.
class Singleton{
  Singleton._privateConstructor(); // 외부 call 방지
  static final Singleton _instance = Singleton._privateConstructor();

  // factory 메서드를 통해 싱글턴을 잡을 수 있음. 외부에서는 일반 생성자, 내부에서는 자체적으로 객체가 생성되지 않음.
  factory Singleton(){
    return _instance;
  }
  
}

main(){
  User user = User('shin', 29);
  User.one();
  User user2 = User.two('shin2');
  print(user.name);
  print(user2.name);

  Singleton obj1 = Singleton();
  Singleton obj2 = Singleton();
  print(obj1 == obj2);

}
