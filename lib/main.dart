import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cvtimesave/system/Utils.dart';
import 'package:cvtimesave/system/user.dart';
import 'package:cvtimesave/view/member/LoginView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_version/get_version.dart';
import 'package:url_launcher/url_launcher.dart';

import 'view/FrontPageView.dart';

void main() {
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'สอบติดแน่',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      builder: EasyLoading.init(
        builder: (BuildContext context, Widget child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaleFactor: 1.0),
            child: child,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var user = User();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAppData();
  }

  checkAppData() async {
    String platform;
    String version;

    if (Platform.isIOS) {
      platform = "ios";
    } else {
      platform = "android";
    }

    try {
      version = await GetVersion.projectVersion;
    } on PlatformException {
      version = 'Failed to get project version.';
    }

    var rs = await Utils().checkAppData(platform, version);

    if (rs["status"].toString() == "0") {
      checkAppVersion(rs["msg"].toString(), rs["url"].toString(), rs["important"].toString());
    } else {
      checkIsLogin();
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
      exit(0);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> checkAppVersion(msg, url, important) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ยืนยัน'),
              onPressed: () {
                if (important == "1") {
                  _launchInBrowser(url);
                } else {
                  checkIsLogin();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  checkIsLogin() async {
    await user.init();
    if (user.isLogin) {
      Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FrontPageView()),
        ),
      );
    } else {
      Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(image: AssetImage('assets/images/splash_screen.png'), fit: BoxFit.cover),
      ),
    ));
  }
}
