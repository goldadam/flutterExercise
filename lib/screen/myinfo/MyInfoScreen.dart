import 'package:flutter/material.dart';

// 프로필사진 변경시 사진이 갱신되어야 하기 때문에
// Stateful로 준비
class Myinfoscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyInfoScreenState();
  }
}

class MyInfoScreenState extends State<Myinfoscreen> {
  // 유저 입력 데이터
  String? email = '';
  String? phone = '';
  String userImage = 'assets/images/user_basic.jpg';

  // form 위젯에 설정할 키. 필요한 순간 이 키를 사용해
  // Form의 State를 획득하기 위함.
  final formKey = GlobalKey<FormState>();

  // 입력 요소 저장을 위해 호출..
  Future<void> saveData() async {
    print('email:  : $email');
    print('phone:  : $phone');
    print('photo:  : $userImage');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보'),
        actions: [
          // AppBar에 들어가는 정보들
          TextButton(
            onPressed: () {
              // 키를 이용해서 widget의 state객체를 얻음.
              // validate()호출하는 순간 form 하위의 모든 위젯의 validator에 등록된 함수가 호출
              // 모두 null을 return -> 전체가 valid하기 때문에 true
              // 하나라도 문자열을 return -> 전체 invalid -> false
              final form = formKey
                  .currentState; // stateful widget이면 아무 객체나 관계없이 얻을 수 있음,
              if (form?.validate() ?? false) {
                form?.save(); // 모든 하위의 onSaved() 호출.. 적절하게 입력데이터 저장..
                saveData();
              }
            },
            child: Text(
              '저장',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 30),
              // 프로필사진
              Card(
                elevation: 0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.asset(userImage, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(onPressed: () {}, child: Text('Gallery App')),
              SizedBox(height: 24),
              ElevatedButton(onPressed: () {}, child: Text('Camera App')),
              SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Form과 상호작용하여 준비된 위젯을 사용해야 하며, TextField는 사용할 수 없음.
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          // nullable이기 때문에 if에 들여보내기 위해 null이면 false로 봄
                          return 'Please enter your email';
                        }
                        return null; // valid한 경우.
                      },
                      // Form State의 saved인 경우 사용
                      onSaved: (value) {
                        email = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'phone'),
                      keyboardType: TextInputType.phone, // 키보드 타입으로 변경
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'Please enter your phone';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        phone = value;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
