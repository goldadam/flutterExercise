import 'package:flutter/material.dart';
import 'package:flutter_lab/screen/main/widgets/MainDrawer.dart';

import '../myinfo/MyInfoScreen.dart';
import './dto/DestinationDto.dart';
import './widgets/DestinationCard.dart';

class MainScreen extends StatelessWidget {
  // 화면 구성을 위한 가상의 데이터....
  final List<DestinationDto> destinations = [
    DestinationDto(
      id: 1,
      image: 'assets/images/main_swiss.jpg',
      destination: '스위스',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 2,
      image: 'assets/images/main_australia.jpg',
      destination: '호주',
      discount: '최대 10% 할인',
    ),
    DestinationDto(
      id: 3,
      image: 'assets/images/main_georgia.jpg',
      destination: '조지아',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 4,
      image: 'assets/images/main_mongolia.jpg',
      destination: '몽골',
      discount: '최대 20% 할인',
    ),
    DestinationDto(
      id: 5,
      image: 'assets/images/main_nepal.jpg',
      destination: '네팔',
      discount: '최대 15% 할인',
    ),
    DestinationDto(
      id: 6,
      image: 'assets/images/main_hawaii.jpg',
      destination: '하와이',
      discount: '최대 5% 할인',
    ),
  ];

  // 화면 구성을 위한 위젯을 준비하는 개발자 함수.. build 함수에서 호출
  // 약간의 로직이 필요해서 뺐음.
  List<Widget> makeDestinationGrid() {
    return destinations.map((destinations) {
      return Destinationcard(destinations);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp 은 runApp()에 의해 출력되는 위젯에서...
    // 각 화면단위 위젯들은 Scaffold를 루트로...
    return Scaffold(
      appBar: AppBar(title: Text('MainScreen')),
      drawer: Maindrawer(),
      // 화면을 구성해서 위젯이 나열되다가.... 화면을 벗어나게 되면..
      // 스크롤을 신경쓰지 않았다는 검정 / 노랑 패턴의 경고 화면이 나온다...
      // 스크롤도 위젯이며, 추가로 준비해야 함.
      // SingleChildScrollView와 ListView 대표적으로 두가지를 사용할 수 있음.
      // 하위에 하나의 위젯만 추가 가능 <-> 여러개의 위젯을 추가 가능
      // 하기의 경우 컬럼 하나로 다 묶여있기 때문에 SingleChildScrollView를 사용하면 됨
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // 화면에 출력되는 특정 영역을 다양한 설정..
              width: double.infinity,
              constraints: BoxConstraints(maxHeight: 300),
              // 화면의 제약.. 세로방향의 최대는 300 이내에서만
              child: Image.asset(
                "assets/images/main_bg_1.jpg",
                width: double.infinity,
                fit: BoxFit.cover, // 실제 이미지 사이즈와 다를때 사용하는 옵션
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // 가로 방향..(사이를 균등하게 지정)
                children: [
                  Text(
                    '특가 여행지',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  // 아이콘까지 같이 나오는 버튼을 사용함.
                  ElevatedButton.icon(
                    onPressed: () {
                      // 화면을 이동하기 위함.
                      Navigator.pushNamed(context, '/event');
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventScreen()),

                      );
                       */
                    },
                    icon: Icon(Icons.arrow_drop_down, size: 20),
                    label: Text('전체 여행지 보기'),
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Color(0xFF3899DD),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              // symmetric 가로(왼쪽, 오른쪽), 세로(위, 아래) 동일 사이즈....
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.count(
                // 차지할 만큼 무한으로 사이즈를 차지하지 말고.. 컨텐츠 크기만큼만 차지해라...
                shrinkWrap: true,
                // GridView는 자체 스크롤을 지원한다.. 너네 스크롤 지원하지 말고.. 화면 전체의 스크롤을 따라가라..
                physics: NeverScrollableScrollPhysics(),
                // 그리드 독자 스크롤 disable
                crossAxisCount: 2,
                // 가로 방향으로 카드를 두개만 배치하게끔..
                childAspectRatio: 0.85,
                // 각 아이템의 가로:세로 비율....
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: makeDestinationGrid(), // 사용자 지정 함수.
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Myinfoscreen()),
                );
              },
              child: Text('Go My Info'),
            ),
          ],
        ),
      ),
    );
  }
}
