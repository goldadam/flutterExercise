import 'package:flutter/material.dart';
import 'package:flutter_lab/provider/MyInfoModel.dart';
import 'package:flutter_lab/screen/bloc/BlocMainScreen.dart';
import 'package:flutter_lab/screen/detail/DetailScreen.dart';
import 'package:flutter_lab/screen/dio/DioTestScreen.dart';
import 'package:flutter_lab/screen/event/EventScreen.dart';
import 'package:flutter_lab/screen/main/mainScreen.dart';
import 'package:flutter_lab/screen/myinfo/MyInfoScreen.dart';
import 'package:flutter_lab/screen/platform/PlatformScreen.dart';
import 'package:flutter_lab/screen/provider/ProviderMainScreen.dart';
import 'package:provider/provider.dart';

// EntryPoint.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 보통 provider를 먼저 사용하게 함.
    return ChangeNotifierProvider(
      // 앱 전역에 상태 데이터를 공개하면서.. 초기 데이터를 유지하게 함...
      // 객체 .. 함수 순차 실행해 초기 데이터가 유지되게끔함..
      create: (context) => MyinfoModel()..loadUserInfo(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // 디버그 띠가 사라짐.
        initialRoute: '/main',

        // 중첩구조로도 등록 가능하다.. 화면이 너무 많은 경우 한곳에 다 등록하지 않고 나누어서 등록이 가능하다
        // main - MaterialApp -> UserHome
        // UserHome에서 다시 MaterialApp을 이용해 자신 업무에 필요한 화면을 다시 등록 가능하다.
        routes: {
          '/main': (context) => MainScreen(),
          '/event': (context) => EventScreen(),
          '/myinfo': (context) => Myinfoscreen(),
          '/dio': (context) => DioTestScreen(),
          '/provider': (context) => ProviderMainScreen(),
          '/bloc': (context) => BlocMainScreen(),
          '/platform': (context) => PlatformScreen(),
        },
        // 화면전환 요청을 받았을 때 처리할 로직이 있다고 한다면? if) 무언가 판단해서
        // 처리해야 하거나, 화면 전환시 어떤 데이터가 준비되어야 하거나 등..
        // 매개변수는 지금 발생한 화면전환 요청 정보.. 이름 및 argument
        onGenerateRoute: (setting) {
          if (setting.name == '/detail') {
            // 필요한 로직 .. (detail로 요청이 왔다고 하면?)
            // route정보는 내가 만들기 나름
            return MaterialPageRoute(
              builder: (context) => Detailscreen(),
              settings:
                  setting, // 추가해줘야 한다. 화면 전환 요청한 곳에서 필요한 데이터가 있을 수 있기 때문..
            );
          }
        },

        // home: MainScreen(),
      ),
    );
  }
}
