import 'package:cvtimesave/system/Utils.dart';
import 'package:cvtimesave/system/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';

import '../FrontPageView.dart';
import 'LoginView.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _fullname = TextEditingController();
  final _schoolClass = TextEditingController();
  final _schoolName = TextEditingController();
  final _goal = TextEditingController();

  bool isCanNext = false;

  var user = User();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  checkCanPass() {
    setState(() {
      if (_fullname.text.isNotEmpty && _schoolClass.text.isNotEmpty && _schoolName.text.isNotEmpty && _goal.text.isNotEmpty) {
        isCanNext = true;
      } else {
        isCanNext = false;
      }
    });
  }

  updateUserData() async {
    EasyLoading.show(status: 'loading...');
    var rs = await Utils().updateUserData(user.uid, _fullname.text.toString(), _schoolClass.text.toString(), _schoolName.text.toString(), _goal.text.toString());

    await user.init();
    user.fullname = _fullname.text.toString();
    user.goal = _goal.text.toString();

    Toast.show(rs["msg"].toString(), context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    EasyLoading.dismiss();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => FrontPageView()),
      ModalRoute.withName("/"),
    );
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
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              logOut();
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text("ลงทะเบียน"),
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
                        //_fullname
                        Container(
                          margin: EdgeInsets.only(top: 33),
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "ชื่อ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF707070),
                                  ),
                                ),
                              ),
                              Container(
                                child: TextField(
                                  controller: _fullname,
                                  maxLength: 50,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                    isDense: true,
                                    counterText: '',
                                    fillColor: Color(0xFFFFFFFF),
                                    filled: true,
                                    hintText: 'ชื่อเล่นหรือชื่อจริง',
                                    hintStyle: TextStyle(color: Color(0xFFBFBFBF), fontSize: 22),
                                  ),
                                  onChanged: (text) {
                                    checkCanPass();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //_schoolClass
                        Container(
                          margin: EdgeInsets.only(top: 33),
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "ระดับชั้น",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF707070),
                                  ),
                                ),
                              ),
                              Container(
                                child: TextField(
                                  controller: _schoolClass,
                                  maxLength: 50,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                    isDense: true,
                                    counterText: '',
                                    fillColor: Color(0xFFFFFFFF),
                                    filled: true,
                                    hintText: 'ม.4',
                                    hintStyle: TextStyle(color: Color(0xFFBFBFBF), fontSize: 22),
                                  ),
                                  onChanged: (text) {
                                    checkCanPass();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //_schoolName
                        Container(
                          margin: EdgeInsets.only(top: 33),
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "โรงเรียน",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF707070),
                                  ),
                                ),
                              ),
                              Container(
                                child: TextField(
                                  controller: _schoolName,
                                  maxLength: 50,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                    isDense: true,
                                    counterText: '',
                                    fillColor: Color(0xFFFFFFFF),
                                    filled: true,
                                    hintText: 'ชื่อโรงเรียนปัจจุบัน',
                                    hintStyle: TextStyle(color: Color(0xFFBFBFBF), fontSize: 22),
                                  ),
                                  onChanged: (text) {
                                    checkCanPass();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //_goal
                        Container(
                          margin: EdgeInsets.only(top: 33),
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "เป้าหมาย",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF707070),
                                  ),
                                ),
                              ),
                              Container(
                                child: TextField(
                                  controller: _goal,
                                  maxLength: 50,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF707070),
                                      ),
                                    ),
                                    isDense: true,
                                    counterText: '',
                                    fillColor: Color(0xFFFFFFFF),
                                    filled: true,
                                    hintText: 'เช่น สอบเข้าวิศวะ จุฬา',
                                    hintStyle: TextStyle(color: Color(0xFFBFBFBF), fontSize: 22),
                                  ),
                                  onChanged: (text) {
                                    checkCanPass();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //btnLogin
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          margin: EdgeInsets.only(top: 33, bottom: 70),
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
                                updateUserData();
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
