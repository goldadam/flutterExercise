import 'package:flutter/material.dart';
import '../dto/EventDto.dart';

class EventCard extends StatelessWidget {
  EventDto vo;

  // 생성자 매개변수 ..
  EventCard(this.vo);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Color(0xFF3899DD)),
        Align(
          alignment: Alignment(0.0, 0.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 이미지 사이즈가 안맞을 경우 사각형으로 잘라라.
                  ClipRect(
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        vo.image,
                        width: 350,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 120,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // 문자열 왼쪽 정렬
                      children: [
                        Text(
                          vo.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(vo.content),
                        SizedBox(height: 4),
                        Text(vo.date),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 30,
                bottom: 110,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black,
                  child: Text(
                    vo.discount,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
