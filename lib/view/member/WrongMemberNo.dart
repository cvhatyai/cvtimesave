import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WrongMemberNo extends StatefulWidget {
  final String title, description;

  //final Image img;

  const WrongMemberNo({
    Key? key,
    this.title = "",
    this.description = "",
  }) : super(key: key);

  @override
  _WrongMemberNoState createState() => _WrongMemberNoState();
}

class _WrongMemberNoState extends State<WrongMemberNo> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Color(0xFF003566),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 32,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Image.asset(
                      "assets/images/wrong.png",
                      width: 50,
                    )),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 160,
                  height: 48.0,

                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF003566),
                              Color(0xFF003566),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFFFFDD00),
                        ),
                      ),
                      child: Container(

                        alignment: Alignment.center,
                        child: Text(
                          "ตกลง",
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFFFFDD00), fontSize: 18.0,),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
