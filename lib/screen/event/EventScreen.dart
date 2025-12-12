import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import './dto/EventDto.dart';
import './widgets/EventCard.dart';

class EventScreen extends StatefulWidget {
  // 손가락에 따라 위젯이 바껴야 하기 때문에 Stateful

  @override
  State<StatefulWidget> createState() {
    return EventScreenState();
  }
}

class EventScreenState extends State<EventScreen> {
  // EventDto vo = EventDto(
  //   'assets/images/main_australia.jpg',
  //   '호주',
  //   '2025-12-10',
  //   '시드니 + 멜버른',
  //   '20%',
  // );

  List<EventDto> datas = [
    EventDto(
      'assets/images/main_australia.jpg',
      '호주',
      '시드니+멜버른+브리즈번',
      '2.14(금) ~ 2.23(일)',
      '20%',
    ),
    EventDto(
      'assets/images/main_georgia.jpg',
      '조지아',
      '나리칼라+게르게티',
      '2.14(금) ~ 2.29(토)',
      '99%',
    ),
    EventDto(
      'assets/images/main_hawaii.jpg',
      '하와이',
      '호놀룰루+마우이',
      '2.15(토) ~ 2.20(목)',
      '20%',
    ),
    EventDto(
      'assets/images/main_mongolia.jpg',
      '몽골',
      '울란바토르+알타이',
      '2.17(월) ~ 2.23(일)',
      '20%',
    ),
    EventDto(
      'assets/images/main_nepal.jpg',
      '네팔',
      '카트만두+ABC',
      '2.21(금) ~ 3.8(일)',
      '15%',
    ),
  ];

  List<EventCard> makePagerWidgets() {
    return datas.map((dto) {
      return EventCard(dto);
    }).toList();
  }

  // PageView에 의해 순차적으로 화면이 나온다.
  // PageView 설정, 하단에 indicator를 제공한다면.. indicator에게 pageview에서 선택한 화면 정보가
  // 전달되어야 한다. -- user가 몇번째 화면을 보는지 정보가 필요함.
  // 이곳에 설정된 대로 PageView가 나오게 되며
  // 동일 controller를 pageview와 indicator가 갖고 있으면 PageView 조정 내용이 자동으로 indicator에 전달됨.
  PageController controller = PageController(
    initialPage: 0,
    viewportFraction: 0.9, // 현재의 화면을 기준으로 왼쪽, 오른쪽에 있는 화면을 얼마나 같이 보여줄 것인지..
    // 0.0 ~ 1.0 사이의 값을 줌.
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 스크린 전체를 위한 위젯이므로 scaffold
      body: Container(
        color: Colors.blue,
        child: Column(
          // pageview와 indicator가 위아래로..
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                children: makePagerWidgets(), // data들을 다 가져옴.
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: 5,
              effect: WormEffect(
                dotColor: Colors.white,
                activeDotColor: Colors.red,
              ),
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
