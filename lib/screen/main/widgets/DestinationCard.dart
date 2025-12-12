import 'package:flutter/material.dart';
import '../../detail/DetailScreen.dart';
import '../dto/DestinationDto.dart';

// 여행지 하나를 화면에 출력하기 위한 위젯...
class Destinationcard extends StatelessWidget {
  final DestinationDto destinationDto;

  const Destinationcard(this.destinationDto);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      // 카드모양, RoundedRectangleBorder(권장), CircleBorder(원형..), StadiumBorder(캡슐..)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // 얼마나 모서리를 둥글게 만들 것이냐.
      ),
      // 유저 이벤트를 처리하기 위한 위젯.. 어떤 위젯이든 이 InkWell로 감싸서 이벤트 처리 가능..
      // InkWell - 유저 이벤트시에.. 이벤트 UI 효과(잉크 번지는 듯한) 제공..
      // GestureDetector = 이벤트만 받아들이고 UI 효과는 존재하지 않음..
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Detailscreen()),
          // );
          // detail로 화면 전환
          Navigator.pushNamed(context, '/detail', arguments: {'destination' : destinationDto});
        },
        // 이벤트시에 잉크 번지는 듯한 효과가 나오는데 어디까지 나올 것인가?
        // 만약 설정을 하지 않으면.. Card의 밖 영역까지 나올 수 있다.
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0), // 4방향.. 단일 방향은 only()
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  // Clip Rounded Rect - 내용을 round rect로 잘라서 출력하는 위젯..
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      destinationDto.image,
                      width: 150,
                      fit: BoxFit
                          .cover, // 위젯의 사이즈와 출력되는 이미지의 사이즈가 맞지 않을 때 어떻게 할 것인지.
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4), //사이즈만 확보하는 위젯..
              Text(
                destinationDto.destination,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                destinationDto.discount,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
