import 'dart:async';
import 'dart:convert';

import 'package:cvtimesave/system/Info.dart';
import 'package:cvtimesave/system/Utils.dart';
import 'package:cvtimesave/system/user.dart';
import 'package:cvtimesave/view/FrontPageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

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

  checkUsername() async {
    EasyLoading.show(status: 'loading...');
    if (FocusScope.of(context).isFirstFocus) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }

    Map _map = {};
    _map.addAll({
      "username": _username.text,
    });
    var body = json.encode(_map);
    final client = http.Client();
    final response = await client.post(Uri.parse(Info().checkHasPhone), headers: {"Content-Type": "application/json"}, body: body);
    var rs = json.decode(response.body);

    print("checkHasPhone : " + rs.toString());
    EasyLoading.dismiss();
    var status = rs["status"].toString();
    var otpStatus = rs["otpStatus"].toString();
    var msg = rs["msg"].toString();
    var reference = rs["reference"].toString();
    await user.init();

    if (otpStatus == "failed") {
      Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpView(
            username: _username.text,
            status: status,
            reference: reference,
          ),
        ),
      );
    }
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
                                      Toast.show('หมายเลขโทรศัพท์ไม่ถูกต้อง', context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
                                checkUsername();
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
