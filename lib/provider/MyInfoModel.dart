import 'package:flutter/material.dart';

// 앱 전역에서 유지 이용되는 앱 사용자 정보..
class MyinfoModel  extends ChangeNotifier{

  String email = '';
  String phone = '';
  String userImage = 'assets/images/user_basic.jpg';

  // 상태값 변경을 위해 호출
  void saveMyInfo({String? email, String? phone, String? userImage}){
    bool hasChanged = true;

    if(email != null){
      this.email = email;
      hasChanged = true;
    }
    if(phone != null){
      this.phone = phone;
      hasChanged = true;
    }
    if(userImage != null){
      this.userImage = userImage;
      hasChanged = true;
    }

    // 변경사항이 있다면 전체 반영.
    if(hasChanged){
      notifyListeners();
    }

  }
}