import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lab/provider/MyInfoModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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

  // 앱의 상태 데이터로 유지할 것이기 때문에 주석처리.(provider로 관리)
  // String? email = '';
  // String? phone = '';
  // String userImage = 'assets/images/user_basic.jpg';

  // form 위젯에 설정할 키. 필요한 순간 이 키를 사용해
  // Form의 State를 획득하기 위함.
  final formKey = GlobalKey<FormState>();

  // Form을 이용함으로.. 유저 입력데이터를 Form을 이용하고 있지만...
  // 이 위젯이 출력될때... 기존에 입력된 데이터가 유지되게 하려면... TextEditingController 사용해야 ..
  // 초기값을 지정하고 싶어서 사용하는 것임

  late TextEditingController emailController;
  late TextEditingController phoneController;

  // gallery button callback
  Future<void> openGallery() async {
    // image_picker package 사용..
    ImagePicker picker = ImagePicker();
    // gallery 목록 화면 뜨고.. 유저가 선택한 이미지의 파일정보가 리턴됨...
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (null != image) {
      // provider 등록, 앱 전체에서 사용할 수 있도록..
      Provider.of<MyinfoModel>(
        context,
        listen: false,
      ).saveMyInfo(userImage: image.path);
    }
  }

  // camera button callback
  Future<void> openCamera() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (null != image) {
      Provider.of<MyinfoModel>(
        context,
        listen: false,
      ).saveMyInfo(userImage: image.path);
    }
  }

  // 초기값을 지정하는 것.
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(); // 초기값을 세팅하기위함임.
    phoneController = TextEditingController();
    // 이 위젯의 화면 출력(렌더링) 이 완료된 뒤에 한번 실행할 코드가 있다면???
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 파라미터에 _ 사용하는 것은 파라미터를 사용하지 않는다는 뜻.
      // 이 함수가 렌더링 완료 후 자동으로 호출된다.
      final model = Provider.of<MyinfoModel>(context, listen: false);
      emailController.text = model.email;
      phoneController.text = model.phone;
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  // 입력 요소 저장을 위해 호출..
  Future<void> saveData() async {
    // 기존의 Form데이터 에서 사용했었음..
    // print('email:  : $email');
    // print('phone:  : $phone');
    // print('photo:  : $userImage');

    // 앱의 전역의 데이터가 유지되게..
    final model = Provider.of<MyinfoModel>(context, listen: false);
    model.saveMyInfo(email: emailController.text, phone: phoneController.text);

    // 위의 코드로 provider에 의해 상태 데이터가 표시되고
    // db에도 저장되도록..

    model.insertDB();
    Navigator.pop(context);
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
          // Provider data를 사용하기 위해 Consumer를 사용하도록 변경.
          child: Consumer<MyinfoModel>(
            builder: (context, model, child) {
              return Column(
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
                      // child: Image.asset(model.userImage, fit: BoxFit.cover),
                      child: model.userImage.startsWith('assets/')
                          ? Image.asset(model.userImage, fit: BoxFit.cover)
                          : Image.file(
                              File(model.userImage),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(onPressed: () {
                    openGallery();
                  }, child: Text('Gallery App')),
                  SizedBox(height: 24),
                  ElevatedButton(onPressed: () {
                    openCamera();
                  }, child: Text('Camera App')),
                  SizedBox(height: 30),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Form과 상호작용하여 준비된 위젯을 사용해야 하며, TextField는 사용할 수 없음.
                        TextFormField(
                          controller: emailController,
                          // provider 데이터를 사용하기 위해 controller 등록
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              // nullable이기 때문에 if에 들여보내기 위해 null이면 false로 봄
                              return 'Please enter your email';
                            }
                            return null; // valid한 경우.
                          },

                          // Form State의 saved인 경우 사용
                          // onSaved: (value) {
                          //   email = value;
                          // },
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(labelText: 'phone'),
                          keyboardType: TextInputType.phone, // 키보드 타입으로 변경
                          validator: (value) {
                            if (value?.isEmpty ?? false) {
                              return 'Please enter your phone';
                            }
                            return null;
                          },
                          // Form이 아닌 Provider로 변경했기 때문에 주석처리
                          //
                          // onSaved: (value) {
                          //   phone = value;
                          // },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
