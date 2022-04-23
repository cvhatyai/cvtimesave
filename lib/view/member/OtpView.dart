import 'dart:async';
import 'dart:convert';

import 'package:cvtimesave/system/Info.dart';
import 'package:cvtimesave/system/Utils.dart';
import 'package:cvtimesave/system/user.dart';
import 'package:cvtimesave/view/FrontPageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import 'RegisterView.dart';
import 'WrongMemberNo.dart';

class OtpView extends StatefulWidget {
  const OtpView({
    Key? key,
    this.username = "",
    this.status = "",
    this.reference = "",
  }) : super(key: key);

  final String username;
  final String status;
  final String reference;

  @override
  _OtpViewState createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  Color activeBtn = Color(0xFF0173FF);
  Color inActiveBtn = Color(0xFFD3D7E2);
  Color activeBtnText = Color(0xFFFFFFFF);
  Color inActiveBtnText = Color(0xFF878FA5);

  var user = User();

  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  bool hasError = false;

  String reference = "";

  int countTouch = 0;
  bool emergency = false;
  bool otpActive = false;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  CountdownTimerController? controller;

  int countWrongPassword = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reference = widget.reference;
  }

  void onEnd() {
    countTouch++;
    if (mounted)
      setState(() {
        otpActive = true;
      });
  }

  Future<void> sendOverOTP() async {
    Map _map = {};
    _map.addAll({
      "phone": widget.username,
      "emergency": emergency,
    });
    var body = json.encode(_map);
    final client = http.Client();
    final response = await client.post(Uri.parse(Info().otpOverUse), headers: {"Content-Type": "application/json"}, body: body);
  }

  checkHasPhone() async {
    Map _map = {};
    _map.addAll({
      "username": widget.username,
    });
    var body = json.encode(_map);
    final client = http.Client();
    final response = await client.post(Uri.parse(Info().checkHasPhone), headers: {"Content-Type": "application/json"}, body: body);

    var rs = json.decode(response.body);

    setState(() {
      reference = rs["reference"];
    });

    if (rs["otpStatus"] == "failed") {
      Toast.show(rs["msg"].toString(), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    } else {
      Toast.show("ระบบได้ส่งรหัสยืนยันไปยังเบอร์โทรของท่านแล้ว", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  setCannotRequestOtp() async {
    var rs = await Utils().setCannotRequestOtp(widget.username);
    Toast.show(rs["msg"].toString(), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    Navigator.pop(context);
  }

  checkOtp() async {
    EasyLoading.show(status: 'loading...');
    if (FocusScope.of(context).isFirstFocus) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }
    Map _map = {};
    _map.addAll({
      "username": widget.username,
      "otp": currentText,
    });
    var body = json.encode(_map);
    final client = http.Client();
    final response = await client.post(Uri.parse(Info().checkOtp), headers: {"Content-Type": "application/json"}, body: body);
    var rs = json.decode(response.body);
    var status = rs["status"].toString();
    var msg = rs["msg"].toString();

    if (status == "success") {
      if (widget.status == "success") {
        _login();
      } else {
        _insertUser();
      }
    } else {
      EasyLoading.dismiss();
      //ให้นับถ้าใส่ผิด
      countWrongPassword++;
      if (countWrongPassword >= 5) {
        setCannotRequestOtp();
      } else {
        var totalLeft = (5 - countWrongPassword).toString();
        Toast.show("คุณสามารถใส่รหัสได้อีก " + totalLeft + " ครั้ง", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        errorController?.add(ErrorAnimationType.shake);
        setState(() => hasError = true);
      }
    }
  }

  _login() async {
    Map _map = {};

    _map.addAll({
      "username": widget.username,
    });

    var body = json.encode(_map);
    final client = http.Client();
    final response = await client.post(Uri.parse(Info().userLogin), headers: {"Content-Type": "application/json"}, body: body);
    var rs = json.decode(response.body);
    EasyLoading.dismiss();
    var status = rs["status"].toString();
    var msg = rs["msg"].toString();
    await user.init();

    if (status == "success") {
      user.isLogin = true;
      user.uid = rs["uid"].toString();
      user.fullname = rs["fullname"].toString();
      user.username = rs["username"].toString();
      user.goal = rs["goal"].toString();
      user.authen_token = rs["authen_token"].toString();

      if (user.fullname == "") {
        //กรอกชื่อรายละเอียด
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterView()),
        );
      } else {
        Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => FrontPageView()),
          ModalRoute.withName("/"),
        );
      }
    } else {
      Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
    if (FocusScope.of(context).isFirstFocus) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }
  }

  _insertUser() async {
    Map _map = {};

    _map.addAll({
      "username": widget.username,
      "type": "phone",
    });

    var body = json.encode(_map);
    final client = http.Client();
    final response = await client.post(Uri.parse(Info().insertUser), headers: {"Content-Type": "application/json"}, body: body);
    var rs = json.decode(response.body);
    EasyLoading.dismiss();
    var status = rs["status"].toString();
    var msg = rs["msg"].toString();

    await user.init();
    if (status == "success") {
      user.isLogin = true;
      user.uid = rs["uid"].toString();
      user.fullname = rs["fullname"].toString();
      user.username = rs["username"].toString();
      user.authen_token = rs["authen_token"].toString();

      if (user.fullname == "") {
        //กรอกชื่อรายละเอียด
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterView()),
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => FrontPageView()),
          ModalRoute.withName("/"),
        );
      }
    } else {
      Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                        //title1
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            "ป้อนรหัสตอนนี้",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),

                        //title2
                        Container(
                          margin: EdgeInsets.only(top: 14.68),
                          child: Text(
                            "รอรับรหัส OTP ภายใน 60 วินาที",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),

                        //pin
                        Container(
                          margin: EdgeInsets.only(top: 24.32),
                          child: Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: PinCodeTextField(
                                autoFocus: true,
                                appContext: context,
                                textStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                pastedTextStyle: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 6,
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.underline,
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  activeColor: Color(0xFF0173FF),
                                  activeFillColor: Colors.transparent,
                                  inactiveColor: Color(0xFF0173FF),
                                  selectedColor: Color(0xFF0173FF),
                                  inactiveFillColor: Colors.transparent,
                                  selectedFillColor: Colors.transparent,
                                ),
                                cursorColor: Color(0xFF0173FF),
                                animationDuration: Duration(milliseconds: 300),
                                enableActiveFill: false,
                                errorAnimationController: errorController,
                                controller: textEditingController,
                                keyboardType: TextInputType.number,
                                onCompleted: (v) {
                                  print("Completed");
                                },
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    currentText = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),

                        //refer
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            "(รหัสอ้างอิง : " + reference + ")",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),

                        //btnLogin
                        Container(
                          margin: EdgeInsets.only(left: 22, right: 22, top: 39.77),
                          child: ButtonTheme(
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                formKey.currentState!.validate();
                                if (currentText.length == 6) {
                                  checkOtp();
                                } else {
                                  errorController!.add(ErrorAnimationType.shake);
                                  setState(() => hasError = true);
                                }
                              },
                              child: Center(
                                child: Text(
                                  "ต่อไป",
                                  style: TextStyle(
                                    color: (currentText.length != 6) ? inActiveBtnText : activeBtnText,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: (currentText.length != 6) ? inActiveBtn : activeBtn,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),

                        //footer1
                        Container(
                          margin: EdgeInsets.only(top: 42.47),
                          child: Text(
                            "หากไม่ได้รับรหัส",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),

                        //footer2
                        GestureDetector(
                          onTap: () {
                            print("countTouch : " + countTouch.toString());

                            setState(() {
                              if (otpActive) {
                                if (countTouch >= 3) {
                                  endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 300;
                                  //endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
                                } else {
                                  endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
                                  //endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 5;
                                }
                                if (countTouch == 1) {
                                  sendOverOTP();
                                }
                                if (countTouch == 2) {
                                  emergency = true;
                                  sendOverOTP();
                                }
                                if (countTouch == 3) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return WrongMemberNo(title: "ขอรหัส OTP เกิน 3 ครั้ง", description: "กรุณารอ 5 นาทีเพื่อทำรายการใหม่อีกครั้ง");
                                    },
                                  );
                                } else {
                                  checkHasPhone();
                                }
                                controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
                                controller!.start();
                              }
                              otpActive = false;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 20.53, bottom: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ขอรับรหัส OTP อีกครั้ง",
                                  style: TextStyle(
                                    color: otpActive ? Colors.blue : Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                CountdownTimer(
                                  controller: controller,
                                  onEnd: onEnd,
                                  endTime: endTime,
                                  widgetBuilder: (_, CurrentRemainingTime? time) {
                                    if (time == null) {
                                      return Text('');
                                    }
                                    return Row(
                                      children: [
                                        Text(' ('),
                                        if (time.min != null)
                                          Text(
                                            '${time.min}:',
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        Text(
                                          '${time.sec}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text('s)'),
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
