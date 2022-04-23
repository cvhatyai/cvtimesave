import 'package:cvtimesave/system/Info.dart';
import 'package:cvtimesave/system/Utils.dart';
import 'package:cvtimesave/system/user.dart';
import 'package:cvtimesave/view/member/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var user = User();

  String status = "failed";
  String totalTimeHr = "00";
  String totalTimeMinute = "00";
  String startDate = "";
  String peakTimeHr = "00";
  String peakTimeMinute = "00";
  String peakDate = "";
  String avgTimeHr = "00";
  String avgTimeMinute = "00";

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  late WebViewController _webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timeDetail();
  }

  void _onRefresh() async {
    timeDetail();
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    reloadWebView();
  }

  void reloadWebView() {
    _webViewController.reload();
  }

  timeDetail() async {
    await user.init();
    var rs = await Utils().timeDetail(user.uid);
    setState(() {
      status = rs["status"];
      totalTimeHr = rs["totalTimeHr"];
      totalTimeMinute = rs["totalTimeMinute"];
      startDate = rs["startDate"];
      peakTimeHr = rs["peakTimeHr"];
      peakTimeMinute = rs["peakTimeMinute"];
      peakDate = rs["peakDate"];
      avgTimeHr = rs["avgTimeHr"];
      avgTimeMinute = rs["avgTimeMinute"];
    });
  }

  logOut() async {
    await user.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
      ModalRoute.withName("/"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
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
                        GestureDetector(
                          onTap: () {
                            logOut();
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Image.asset(
                              'assets/images/frontpage/noti.png',
                              width: 30.79,
                              height: 30.3,
                            ),
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
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                children: [
                                  TextSpan(
                                    text: user.goal,
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
                          height: 250,
                          child: status == "failed"
                              ? Icon(
                                  Icons.insert_chart_outlined_rounded,
                                  size: 150,
                                  color: Color(0xFF0173FF),
                                )
                              : Center(
                                  child: WebView(
                                    onWebViewCreated: (controller) {
                                      _webViewController = controller;
                                    },
                                    initialUrl: Info().baseUrl + "graph?uid=" + user.uid,
                                    javascriptMode: JavascriptMode.unrestricted,
                                  ),
                                ),
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
                                            TextSpan(text: totalTimeHr, style: TextStyle(fontSize: 30)),
                                            TextSpan(text: " ชั่วโมง ", style: TextStyle(fontSize: 17)),
                                            TextSpan(text: totalTimeMinute, style: TextStyle(fontSize: 30)),
                                            TextSpan(text: " นาที", style: TextStyle(fontSize: 17)),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        startDate,
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
                                            TextSpan(text: peakTimeHr, style: TextStyle(fontSize: 30)),
                                            TextSpan(text: " ชั่วโมง ", style: TextStyle(fontSize: 17)),
                                            TextSpan(text: peakTimeMinute, style: TextStyle(fontSize: 30)),
                                            TextSpan(text: " นาที", style: TextStyle(fontSize: 17)),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        peakDate,
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
                                        TextSpan(text: avgTimeHr, style: TextStyle(fontSize: 30)),
                                        TextSpan(text: " ชั่วโมง ", style: TextStyle(fontSize: 17)),
                                        TextSpan(text: avgTimeMinute, style: TextStyle(fontSize: 30)),
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
      ),
    );
  }
}
