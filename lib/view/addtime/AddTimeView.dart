import 'dart:async';
import 'dart:convert';

import 'package:cvtimesave/system/Info.dart';
import 'package:cvtimesave/system/Utils.dart';
import 'package:cvtimesave/system/user.dart';
import 'package:cvtimesave/view/FrontPageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class AddTimeView extends StatefulWidget {
  const AddTimeView({Key? key}) : super(key: key);

  @override
  _AddTimeViewState createState() => _AddTimeViewState();
}

class _AddTimeViewState extends State<AddTimeView> {
  int indexSelected = 0;

  Color timeSelectedTextColor = Colors.white;
  Color timeSelectedBgColor = Color(0xFF0173FF);

  Color timeUnselectTextColor = Color(0xFF0173FF);
  Color timeUnselectBgColor = Color(0xFFE2EFFF);

  TextEditingController hrController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  setSelectAnimate(index) {
    setState(() {
      indexSelected = index;
      if (indexSelected == 1) {
        hrController.text = "";
        minuteController.text = "30";
      } else if (indexSelected == 2) {
        hrController.text = "1";
        minuteController.text = "";
      } else if (indexSelected == 3) {
        hrController.text = "2";
        minuteController.text = "";
      } else if (indexSelected == 4) {
        hrController.text = "1";
        minuteController.text = "30";
      }
    });
  }

  insertTime() async {
    if (hrController.text.toString() == "" && minuteController.text.toString() == "") {
      Toast.show("กรุณากรอกชั่วโมงหรือนาที", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      EasyLoading.show(status: 'loading...');
      var rs = await Utils().insertTime(hrController.text.toString(), minuteController.text.toString());
      Toast.show(rs["msg"].toString(), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      EasyLoading.dismiss();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => FrontPageView()),
        ModalRoute.withName("/"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/frontpage/top_bg.png'), fit: BoxFit.contain, alignment: Alignment.topCenter),
            ),
            child: Column(
              children: [
                Container(
                  height: 58,
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => FrontPageView()),
                            ModalRoute.withName("/"),
                          );
                        },
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            "บันทึกเวลาทำโจทย์",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.transparent,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 18, right: 18, top: 45, bottom: 100),
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

                      //time select
                      Container(
                        height: 42,
                        margin: EdgeInsets.only(top: 24),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 11, left: 20),
                              child: Image.asset(
                                'assets/images/popup/clock.png',
                                width: 24.55,
                                height: 24.55,
                              ),
                            ),

                            //30 นาที
                            GestureDetector(
                              onTap: () {
                                setSelectAnimate(1);
                              },
                              child: Container(
                                key: UniqueKey(),
                                margin: EdgeInsets.only(right: 11),
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                decoration: BoxDecoration(
                                  color: indexSelected == 1 ? timeSelectedBgColor : timeUnselectBgColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "30 นาที",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: indexSelected == 1 ? timeSelectedTextColor : timeUnselectTextColor,
                                  ),
                                ),
                              ),
                            ),

                            //1 ชั่วโมง
                            GestureDetector(
                              onTap: () {
                                setSelectAnimate(2);
                              },
                              child: Container(
                                key: UniqueKey(),
                                margin: EdgeInsets.only(right: 11),
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                decoration: BoxDecoration(
                                  color: indexSelected == 2 ? timeSelectedBgColor : timeUnselectBgColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "1 ชั่วโมง",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: indexSelected == 2 ? timeSelectedTextColor : timeUnselectTextColor,
                                  ),
                                ),
                              ),
                            ),

                            //2 ชั่วโมง
                            GestureDetector(
                              onTap: () {
                                setSelectAnimate(3);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 11),
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                decoration: BoxDecoration(
                                  color: indexSelected == 3 ? timeSelectedBgColor : timeUnselectBgColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "2 ชั่วโมง",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: indexSelected == 3 ? timeSelectedTextColor : timeUnselectTextColor,
                                  ),
                                ),
                              ),
                            ),

                            //1 ชั่วโมง 30 นาที
                            GestureDetector(
                              onTap: () {
                                setSelectAnimate(4);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 11),
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                decoration: BoxDecoration(
                                  color: indexSelected == 4 ? timeSelectedBgColor : timeUnselectBgColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "1 ชั่วโมง 30 นาที",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: indexSelected == 4 ? timeSelectedTextColor : timeUnselectTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //line
                      Container(
                        margin: EdgeInsets.only(top: 19),
                        height: 1,
                        color: Color(
                          0xFFD9D9D9,
                        ),
                      ),

                      //time input
                      Container(
                        margin: EdgeInsets.only(top: 45),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 106,
                              height: 110,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/popup/hr_bg.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 22),
                                  child: TextField(
                                    controller: hrController,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 45),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "00",
                                      hintStyle: TextStyle(
                                        color: Color(0xFFB2B2B2),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    onChanged: (val) {
                                      setState(() {
                                        indexSelected = 0;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12, right: 12, top: 20),
                              child: Image.asset(
                                'assets/images/popup/separator.png',
                                width: 12,
                                height: 40,
                              ),
                            ),
                            Container(
                              width: 106,
                              height: 110,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/popup/minute_bg.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 22),
                                  child: TextField(
                                    controller: minuteController,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 45),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "00",
                                      hintStyle: TextStyle(
                                        color: Color(0xFFB2B2B2),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(2),
                                    ],
                                    onChanged: (val) {
                                      setState(() {
                                        indexSelected = 0;
                                      });
                                      if (int.parse(val) > 59) {
                                        minuteController.text = "59";
                                        minuteController.selection = TextSelection.fromPosition(TextPosition(offset: minuteController.text.length));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //btn
                      Container(
                        margin: EdgeInsets.only(bottom: 31, top: 60),
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => FrontPageView()),
                                      ModalRoute.withName("/"),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/cancel_btn.png',
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 10,
                            ),

                            Expanded(
                              child: Container(
                                child: GestureDetector(
                                  onTap: () {
                                    insertTime();
                                  },
                                  child: Image.asset(
                                    'assets/images/save_btn2.png',
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
