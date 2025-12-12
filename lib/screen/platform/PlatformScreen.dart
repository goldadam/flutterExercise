import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformScreen extends StatefulWidget {
  @override
  PlatformScreenState createState() => PlatformScreenState();
}

class PlatformScreenState extends State<PlatformScreen> {
  String? resultMessage;
  String? receiveMessage;

  // Native와 연동 예시
  Future<Null> callNative() async {
    // native와 이름만 동일하면 된다.
    // 하나의 앱에서 여러 채널을 만들어도 된다.
    // 1대1로 braodcast 된다.
    var channel = BasicMessageChannel<String>(
      'myMessageChannel',
      StringCodec(),
    );
    // native에 데이터를 넘겨서 일을 시키기..
    // native의 결과값.. 리턴으로 받으면 된다..
    String? result = await channel.send('Hello i am flutter message');

    setState(() {
      resultMessage = result;
    });

    // native의 데이터를 받기 위해서
    // 원래는 각각 돌려야되는데 세스트 용이성을 위해 하기와 같이 만듦.
    channel.setMessageHandler((String? message) async {
      setState(() {
        receiveMessage = result;
      });
      return 'Hi from Dart';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Channel Test")),
      body: Center(
        child: Column(
          children: (<Widget>[
            Text('resultMessage : $resultMessage'),
            Text('receiveMessage : $receiveMessage'),
            ElevatedButton(onPressed: callNative, child: Text('native call')),
          ]),
        ),
      ),
    );
  }
}
