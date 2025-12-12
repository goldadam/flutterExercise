import 'package:flutter/material.dart';
import 'dart:async';
import '../dto/ArticleDto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailNewsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailNewsWidgetState();
  }
}

class DetailNewsWidgetState extends State<DetailNewsWidget> {
  String _url =
      'https://newsapi.org/v2/everything?q=travel&apiKey=079dac74a5f94ebdb990ecf61c8854b7&pageSize=3';

  // Stream으로 뉴스 기사 받아오게 변경함.
  List<Article> list = []; //서버에서 받아온 data
  late StreamController<List<Article>> streamController;

  // 서버데이터를 이용해서 .. 목록 화면을 구성하는 함수....
  Widget getItemWidget(List<Article> datas) {
    return ListView.builder(
      itemCount: datas.length,
      itemBuilder: (BuildContext context, int position) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                datas[position].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                datas[position].publishedAt,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(datas[position].description),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.network(datas[position].urlToImage),
            ),
            if (position != datas.length - 1)
              Container(height: 15, color: Colors.grey),
          ],
        );
      },
    );
  }



  void periodicFetch() {
    Stream.periodic(Duration(seconds: 5), (count) => count++)
        .take(5) // 5초에 한번씩 5번 아래 함수가 호출되는 것 (비동기로)
        .asyncMap((page) async {
          // 서버 요청
          String url = '$_url&page=$page';
          http.Response response = await http.get(Uri.parse(url));
          List list = json.decode(response.body)['articles'];

          return list
              .map(
                (item) => Article(
                  item['source']['name'],
                  item['title'],
                  item['description'],
                  item['urlToImage'],
                  item['publishedAt'],
                ),
              )
              .toList();
        })
        .listen((list) => streamController.add(list));
  }

  @override
  void initState() {
    // 시작되자마자 바로 일하게끔..
    super.initState();
    streamController = StreamController<List<Article>>();
    periodicFetch();
  }

  @override
  void dispose() {
    // 끝날때 닫아줘야함
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    // stream에서 반복적으로 받아온 데이터를 통해 화면을 구성함
    return StreamBuilder(
      stream: streamController.stream,
      // 최초에 한번 호출.. 데이터가 발생될 때마다 호출..
      // 두번째 매개변수가 발행한 데이터임.
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){

          list.addAll(snapshot.data);
          return getItemWidget(list);
        }else if(snapshot.hasError){
          return Text('${snapshot.error}');
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }
}
