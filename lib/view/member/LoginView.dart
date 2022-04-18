import 'dart:async';

import 'package:cvtimesave/system/Utils.dart';
import 'package:cvtimesave/system/user.dart';
import 'package:cvtimesave/view/FrontPageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';

import 'OtpView.dart';
import 'RegisterView.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _username = TextEditingController();

  bool isCanNext = false;

  var user = User();

  userLogin() async {
    if (FocusScope.of(context).isFirstFocus) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }
    //var rs = await Utils().userLogin(_username.text.toString());
    EasyLoading.dismiss();
    /*if (rs["status"] == "success") {
      await user.init();
      Toast.show(rs["msg"].toString(), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      user.isLogin = true;
      user.uid = rs["uid"].toString();
      user.fullname = rs["fullname"].toString();
      user.username = rs["username"].toString();
      user.authen_token = rs["authen_token"].toString();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => FrontPageView()),
        ModalRoute.withName("/"),
      );
    } else {
      Toast.show(rs["msg"].toString(), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }*/

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text("เข้าสู่ระบบหรือลงทะเบียน"),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/frontpage/top_bg.png'), fit: BoxFit.contain, alignment: Alignment.topCenter),
          ),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 18, right: 18, top: 80),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(19),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(3, 3),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        //username
                        Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          margin: EdgeInsets.only(top: 40),
                          child: TextField(
                            controller: _username,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: InputDecoration(
                              isDense: true,
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              fillColor: Color(0xFFEBEBEB),
                              filled: true,
                              hintText: 'กรอกเบอร์โทรศัพท์',
                              hintStyle: TextStyle(color: Color(0xFF262626), fontSize: 19),
                            ),
                            onChanged: (text) {
                              setState(() {
                                if (text.isNotEmpty) {
                                  if (text.length == 10) {
                                    if (text.toString()[0] != "0") {
                                      isCanNext = false;
                                      Toast.show('หมายเลขโทรศัพท์ไม่ถูกต้อง', context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                                    } else {
                                      isCanNext = true;
                                    }
                                  } else {
                                    isCanNext = false;
                                  }
                                } else {
                                  isCanNext = false;
                                }
                              });
                            },
                          ),
                        ),

                        //btnLogin
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          margin: EdgeInsets.only(top: 16, bottom: 70),
                          height: 44,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(isCanNext ? Color(0xFF0173FF) : Color(0xFFAFAFAF)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (isCanNext) {
                                print("adadad");
                                EasyLoading.show(status: 'loading...');
                                userLogin();
                              }
                            },
                            child: Text(
                              "ต่อไป",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //regis
                  /*  Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterView(),
                            ),
                          );
                        },
                        child: Text("สมัครสมาชิกใหม่"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgetPasswordView(
                                isHaveArrow: "1",
                              ),
                            ),
                          );
                        },
                        child: Text("ลืมรหัสผ่าน?"),
                      ),
                    ],
                  ),
                ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
