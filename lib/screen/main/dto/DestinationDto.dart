//여행지 데이터 추상화..
class DestinationDto {
  final int id;
  final String image;
  final String destination;
  final String discount;


// 모두 required가 붙었으나 개발자 편의성을 위해서
// optional로 만들고 required를 붙임.
// 생성자 생성
const DestinationDto({
    required this.id,
    required this.image,
    required this.destination,
    required this.discount
  });


}