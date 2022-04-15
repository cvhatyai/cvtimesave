import 'dart:async';

import 'package:cvtimesave/system/Utils.dart';
import 'package:cvtimesave/system/user.dart';
import 'package:cvtimesave/view/FrontPageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';

import 'RegisterView.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _username = TextEditingController();
  final _password = TextEditingController();

  bool _validateUsername = false;
  bool _validatePassword = false;

  var user = User();


  userLogin() async {
    if (FocusScope.of(context).isFirstFocus) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }
    var rs = await Utils().userLogin(_username.text.toString(), _password.text.toString());
    EasyLoading.dismiss();
    print("userLogin : " + rs.toString());

    if (rs["status"] == "success") {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            margin: EdgeInsets.only(top: 8),
            child: Column(
              children: [
                //logo
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),

                //username
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: _username,
                    decoration: InputDecoration(
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      hintText: 'เบอร์โทรศัพท์',
                      errorText: _validateUsername ? 'กรุณากรอกเบอร์โทรศัพท์' : null,
                    ),
                  ),
                ),

                //password
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                      hintText: 'รหัสผ่าน',
                      errorText: _validatePassword ? 'กรุณากรอกรหัสผ่าน' : null,
                    ),
                  ),
                ),

                //btnLogin
                Container(
                  margin: EdgeInsets.only(top: 16),
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF0173FF)),
                    ),
                    onPressed: () {
                      setState(() {
                        _username.text.isEmpty ? _validateUsername = true : _validateUsername = false;
                        _password.text.isEmpty ? _validatePassword = true : _validatePassword = false;

                        if (!_validateUsername && !_validatePassword) {
                          EasyLoading.show(status: 'loading...');
                          userLogin();
                        }
                      });
                    },
                    child: Text("เข้าสู่ระบบ"),
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
    ));
  }
}
