import 'package:flutter/material.dart';
import 'package:flutter_lab/screen/detail/widgets/DetailMainWidget.dart';
import 'package:flutter_lab/screen/detail/widgets/DetailNewsWidget.dart';
import 'package:flutter_lab/screen/main/dto/DestinationDto.dart';

//왜 Stateful?
// Bottom Navigator 바에 의해 어떤 버튼이 눌렸는지 / 해당 바에 따라
// 맞는 버튼이 나와야 하기 때문에 stateful
class Detailscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailScreenState();
  }
}

// bottom navigation bar 의 item 클릭시 애니매이션 효과를 위해 mixin을 with로 가져온다.
class DetailScreenState extends State<Detailscreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0; // bottom navigation bar에 선택된 item , 변경시 화면이 갱신됨.

  List<Widget> widgets = [DetailMainWidget(), DetailNewsWidget()];

  // bottom navigation bar의 item 선택 이벤트..
  void onItemTapped(int index) {
    // 화면 갱신
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 파라미터로 전달받은 데이터 추출
    Map<String, Object> args = ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    DestinationDto dto = args['destination'] as DestinationDto; // 전달받은 데이터 추출
    print(dto.destination);
    print("asdfasdfa");



    return Scaffold(
      // nestedScrollView : 화면에 값이 같이 나오는 두 위젯이 같이 접하게 하기 위해서 선택.
      // 화면 윗부분은 위젯 / 유저는 디테일만 스크롤하기 위함.
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            // Scaffold Appbar와 동일 역할을 수행함..
            // Scaffold Appbar는 nestedScrollView와 연동해서 접히는 기능이 없다.
            SliverAppBar(
              expandedHeight: 250.0,
              // 접혔다가 거꾸로 스크롤할때, 가장 처음부터 펼쳐져야 하는 것인지..
              floating: false,
              // 접히다가 완전히 사라질 것인가? 한줄은 남길 것인가?
              pinned: true,
              backgroundColor: Color(0xFF3899DD),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(dto.destination, style: TextStyle(color: Colors.white)),
                titlePadding: EdgeInsets.only(left: 56, bottom: 16),
                // 접혔다가 펼처질때 타티틀 문자열의 크기 배율
                expandedTitleScale: 1.0,
                background: Image.asset(
                  'assets/images/detail_main.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: widgets.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting, // item 클릭시 애니매이션효과를 적용할 것인가?
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main',
            backgroundColor: Color(0xFF3899DD),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'News',
            backgroundColor: Colors.red,
          )
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: onItemTapped,
      ),
    );
  }
}
