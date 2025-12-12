class MyClass{
  MyClass._instance();

  // 개발자 알고리즘에의해 내부에서 준비된 것들만 생성되게
  factory MyClass(){
    return MyClass._instance(); //싱글톤 구현할때 굉장히 편함
    // or 캐싱 알고리즘을 구현할 때 굉장히 편함.
  }


}

class Image{
  late String url;
  static Map<String, Image> _cache = <String, Image>{};

  Image._instance(this.url);
  factory Image(String url){
    if(_cache[url] == null){
      var obj = Image._instance(url);
      _cache[url] = obj;
      print('h');
    }else{
      print('t');
    }
    return _cache[url]!;
  }
}


// const 생성자
class MyClass2{
  final int data1;
  const MyClass2(this.data1);
}


main(){
  var obj = MyClass();
  var imag1 = Image('test');
  var imag2 = Image('test');
  print(imag2.url);
  print(imag1.url);

  var obj1 = MyClass2(10);
  var obj2 = MyClass2(10);
  if(obj1 == obj2){
    print("aa");
  }else{
    print("bb");
  }

}
