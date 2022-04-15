import 'package:cvtimesave/system/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var user = User();

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
                  margin: EdgeInsets.only(top: 30, left: 29, right: 18),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        width: 59,
                        height: 58,
                        child: Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 48,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            user.fullname,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          'assets/images/frontpage/noti.png',
                          width: 30.79,
                          height: 30.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 18, right: 18, top: 15, bottom: 100),
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
                      //title
                      Container(
                        margin: EdgeInsets.only(top: 16.73),
                        child: Center(
                          child: Image.asset(
                            'assets/images/frontpage/title.png',
                            width: 187.04,
                            height: 34.13,
                          ),
                        ),
                      ),
                      //goal
                      Container(
                        height: 39.29,
                        margin: EdgeInsets.only(left: 25, right: 25, top: 12),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F7FF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          /*child: Text(
                            "สอบเข้า ญว ให้ได้",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF33B1F0), // 2 สีคือยังไง ถ้า user พิมมาเองจะกำหนดยังไงว่า สีน้ำเงินถึงตรงไหน ? ใส่สีน้ำเงินทั้งหมด
                            ),
                          ),*/
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              children: [
                                TextSpan(
                                  text: "สอบเข้า ญว",
                                  style: TextStyle(color: Color(0xFF33B1F0)),
                                ),
                                TextSpan(
                                  text: " ให้ได้ ",
                                  style: TextStyle(color: Color(0xFF707070)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //title2
                      Container(
                        margin: EdgeInsets.only(top: 29.86),
                        child: Text(
                          "เวลาทำโจทย์",
                          style: TextStyle(
                            color: Color(0xFF707070),
                          ),
                        ),
                      ),
                      //graph
                      Container(
                        margin: EdgeInsets.only(left: 25, right: 25, top: 12),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.red,
                        height: 230,
                      ),
                      //line
                      Container(
                        margin: EdgeInsets.only(top: 39.5, left: 8, right: 8),
                        height: 1,
                        color: Color(0xFFE1E1E1),
                      ),
                      //เวลาสะสม
                      Container(
                        margin: EdgeInsets.only(top: 15.5),
                        padding: EdgeInsets.symmetric(horizontal: 17),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "เวลาสะสม",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF707070),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Color(0xFF0173FF),
                                        ),
                                        children: [
                                          TextSpan(text: "78", style: TextStyle(fontSize: 30)),
                                          TextSpan(text: " ชั่วโมง ", style: TextStyle(fontSize: 17)),
                                          TextSpan(text: "30", style: TextStyle(fontSize: 30)),
                                          TextSpan(text: " นาที", style: TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "ตั้งแต่ 7 ก.พ. 65",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF575553),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //line
                      Container(
                        margin: EdgeInsets.only(top: 12.5, left: 8, right: 8),
                        height: 1,
                        color: Color(0xFFE1E1E1),
                      ),
                      //สถิติสูงสุด
                      Container(
                        margin: EdgeInsets.only(top: 15.5),
                        padding: EdgeInsets.symmetric(horizontal: 17),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "สถิติสูงสุด",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF707070),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Color(0xFFFF7700),
                                        ),
                                        children: [
                                          TextSpan(text: "78", style: TextStyle(fontSize: 30)),
                                          TextSpan(text: " ชั่วโมง ", style: TextStyle(fontSize: 17)),
                                          TextSpan(text: "30", style: TextStyle(fontSize: 30)),
                                          TextSpan(text: " นาที", style: TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "เมื่อ 7 มี.ค. 65",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF575553),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //line
                      Container(
                        margin: EdgeInsets.only(top: 12.5, left: 8, right: 8),
                        height: 1,
                        color: Color(0xFFE1E1E1),
                      ),
                      //เวลาเฉลี่ย/วัน
                      Container(
                        margin: EdgeInsets.only(bottom: 44, top: 15.5),
                        padding: EdgeInsets.symmetric(horizontal: 17),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "เวลาเฉลี่ย/วัน",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF707070),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Color(0xFF71A507),
                                    ),
                                    children: [
                                      TextSpan(text: "2", style: TextStyle(fontSize: 30)),
                                      TextSpan(text: " ชั่วโมง ", style: TextStyle(fontSize: 17)),
                                      TextSpan(text: "30", style: TextStyle(fontSize: 30)),
                                      TextSpan(text: " นาที", style: TextStyle(fontSize: 17)),
                                    ],
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
