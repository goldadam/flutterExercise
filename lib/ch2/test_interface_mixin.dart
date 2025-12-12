class myClass{
  int no;
  String name;

  myClass(this.no, this.name);

  void myFunc(){}

}

// 클래스를 상속으로..

class subClass extends myClass{
  subClass(no, name): super(no, name);
}

// 클래스를 인터페이스로..
// 클래스에 선언한 모든 멤버를 오버라이드해야 함.
class interfaceClass implements myClass{
  int no = 0;
  String name = '';
  void myFunc(){
    print('hello');
  }
}

// 어떤 클래스의 설계와 관련이 없다.
// 단지 여러 클래스의 코드 중복을 없애기 위해 사용한다.
mixin mixinClass{
  int mixinData = 10;
  void mixinFunc(){}
}

class mixinTestClass with mixinClass{
  void sumFun(){
    mixinData++;
    mixinFunc();
  }
}



void main(){
  mixinTestClass mt = mixinTestClass();
  print(mt.mixinData);



}