import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(
          left: 30,
          top: 60,
          right: 30,
        ), //top 108 ปุ่มล่างหาย
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //title
              Container(
                margin: EdgeInsets.only(top: 26),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/popup/clock.png',
                      width: 24.55,
                      height: 24.55,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 15.45),
                        child: Text(
                          "บันทึกเวลาทำโจทย์",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFF707070),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //time select
              Container(
                height: 42,
                margin: EdgeInsets.only(top: 24),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    //30 นาที
                    GestureDetector(
                      onTap: () {
                        setSelectAnimate(1);
                      },
                      child: Container(
                        key: UniqueKey(),
                        margin: EdgeInsets.only(right: 11, left: 20),
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    'assets/images/save_btn.png',
                    width: 154,
                    height: 48,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
