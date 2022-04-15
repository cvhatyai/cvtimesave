import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _username = TextEditingController();
  final _password1 = TextEditingController();
  final _password2 = TextEditingController();
  final _name = TextEditingController();
  final _goal = TextEditingController();

  bool _validateName = false;
  bool _validateGoal = false;
  bool _validateUsername = false;
  bool _validatePassword1 = false;
  bool _validatePassword2 = false;

  checkUserPhone(){

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0173FF),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('สมัครสมาชิก'),
          centerTitle: true,
        ),
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
                  //username
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 16),
                    child: TextField(
                      controller: _username,
                      keyboardType: TextInputType.number,
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
                  //pass1
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 16),
                    child: TextField(
                      controller: _password1,
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
                        errorText: _validatePassword1 ? 'กรุณากรอกรหัสผ่าน' : null,
                      ),
                    ),
                  ),
                  //pass2
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 16),
                    child: TextField(
                      controller: _password2,
                      obscureText: true,
                      decoration: InputDecoration(
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        hintText: 'ยืนยันรหัสผ่าน',
                        errorText: _validatePassword2 ? 'กรุณากรอกรหัสผ่าน' : null,
                      ),
                    ),
                  ),
                  //fullname
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 16),
                    child: TextField(
                      controller: _name,
                      decoration: InputDecoration(
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        hintText: 'ชื่อ-สกุล',
                        errorText: _validateName ? 'กรุณากรอกชื่อ-สกุล' : null,
                      ),
                    ),
                  ),
                  //goal
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 16),
                    child: TextField(
                      controller: _goal,
                      decoration: InputDecoration(
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        hintText: 'เป้าหมาย',
                        errorText: _validateGoal ? 'กรุณากรอกเป้าหมาย' : null,
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
                          _password1.text.isEmpty ? _validatePassword1 = true : _validatePassword1 = false;
                          _password2.text.isEmpty ? _validatePassword2 = true : _validatePassword2 = false;
                          _name.text.isEmpty ? _validateName = true : _validateName = false;
                          _goal.text.isEmpty ? _validateGoal = true : _validateGoal = false;
                          if (!_validateUsername && !_validatePassword1 && !_validatePassword2 && !_validateName && !_validateGoal) {
                            if (_password1.text == _password2.text) {
                              EasyLoading.show(status: 'loading...');
                              checkUserPhone();
                            } else {
                              if (FocusScope.of(context).isFirstFocus) {
                                FocusScope.of(context).requestFocus(new FocusNode());
                              }
                              Toast.show("กรุณากรอกรหัสผ่านให้ตรงกัน", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                            }
                          }
                        });
                      },
                      child: Text("ยืนยันข้อมูล"),
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
