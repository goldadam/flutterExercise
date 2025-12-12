import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(ParentWidget());

// 상위 부모의 상태가 변경되었을때 하위 child의
// State변경사항을 보기 위함
class ParentWidget extends StatefulWidget{


  @override
  State createState() {
    return ParentState();
  }
}

class ParentState extends State<ParentWidget>{
  // 부모 위젯에서 관리하는 상태 data
  // 하위 위젯에 전파되는 data
  int counter = 0;
  void increment(){
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Lifecycle Test'),),
        body:Provider.value(// 상위의 상태 데이터를 하위에 전파시키기 위한 코드
          value: counter,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('I am parent widget: $counter  '),
                    ElevatedButton(onPressed: increment, child: Text('increment')),
                  ],
                ),
                ChildWidget(),
              ],
            )
          )
        )
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  ChildWidget(){
    print('ChildWidget.... constructor');
  }

  @override
  State createState() {
    return ChildState();
  }
}

//WidgetsBindingObserver - 앱 자체의 라이프사이클 확인.. 앱이 화면에 나오는순간 및 화면에 사라지는 순간..
class ChildState extends State<ChildWidget> with WidgetsBindingObserver{

  int counter = 0; // 상위에서 전달받는 data

  ChildState(){
    print('ChildState.... constructor');
  }

  // lifecycle 함수, 최초 한번.. 상태 데이터 초기화 및 이벤트 등록..
  @override
  void initState() {

    super.initState();
    print('ChildState... initstate');
    WidgetsBinding.instance.addObserver(this); // 앱의 라이프사이클 감지 등록..
  }

  //최후에 한번 호출
  // 이벤트 등록 해제
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this); // 앱의 라이프사이클 감지 등록..
  }

  // initState가 호출된 후에 한번 호출
  // 상위 위젯의 상태가 변경될대..
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('childState... didChangeDependencies');
    counter = Provider.of<int>(context); // 상위 상태 데이터 획득...
  }

  @override
  Widget build(BuildContext context) {
    print('childState build called..');
    return Text('I am a ChildWidget : $counter');
  }

  // 앱의 상태가 변경되었을 때의 call-back 함수
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('didChangeAppLifecycleState... $state');
  }

  // 최초 화면 출력되는 순간................
  // I/flutter (24074): ChildWidget.... constructor
  // I/flutter (24074): ChildState.... constructor
  // I/flutter (24074): ChildState... initstate
  // I/flutter (24074): childState... didChangeDependencies
  // I/flutter (24074): childState build called..


  // 상위 위젯의 상태 data가 변경되는 순간....
  // I/flutter (24074): ChildWidget.... constructor
  // I/flutter (24074): childState... didChangeDependencies
  // I/flutter (24074): childState build called..
  // ==> 상위 위젯의 상태가 변경되었다.. 하위 위젯은 다시 생성된다 .. 위젯은 불변하게 생성되기 때문이다..
  // 너무 높은 범위에서 stateful로 만들면 모든 하위 위젯들이 재생성될것이기 때문에 메모리에 무리가 갈 수 있다.
  // ==> State는 다시 생성되지 않았다.. 초기 생성된 객체를 메모리에 지속시키며 이용된다.

  // 앱이 화면에 안나오면? -> 홈버튼 누르면?
  // I/flutter (24074): didChangeAppLifecycleState... AppLifecycleState.inactive
  // D/VRI[MainActivity](24074): visibilityChanged oldVisibility=true newVisibility=false
  // I/flutter (24074): didChangeAppLifecycleState... AppLifecycleState.hidden
  // I/flutter (24074): didChangeAppLifecycleState... AppLifecycleState.paused

  // 앱이 다시 화면에 나오면?
  // D/ViewRootImpl(24074): Skipping stats log for color mode
  // I/flutter (24074): didChangeAppLifecycleState... AppLifecycleState.hidden
  // I/flutter (24074): didChangeAppLifecycleState... AppLifecycleState.inactive
  // I/flutter (24074): didChangeAppLifecycleState... AppLifecycleState.resumed

  // All Platform을 목표로 만드는 것이기 때문에 여러개가 나온다.

}
