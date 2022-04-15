import 'package:cvtimesave/view/state/StateView.dart';
import 'package:flutter/material.dart';

import 'addtime/AddTimeView.dart';
import 'chat/ChatView.dart';
import 'home/HomeView.dart';
import 'more/MoreView.dart';


class FrontPageView extends StatefulWidget {
  const FrontPageView({Key? key}) : super(key: key);

  @override
  _FrontPageViewState createState() => _FrontPageViewState();
}

class _FrontPageViewState extends State<FrontPageView> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    StateView(),
    HomeView(),
    ChatView(),
    MoreView(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      _showMyDialog();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AddTimeView();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(image: AssetImage('assets/images/frontpage/btm_bar.png'), fit: BoxFit.contain, alignment: Alignment.bottomCenter),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            selectedItemColor: Color(0xFF575553),
            unselectedItemColor: Color(0xFF575553),
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 36),
                  child: Image.asset(
                    'assets/images/frontpage/home.png',
                    width: 22.9,
                    height: 22.9,
                  ),
                ),
                label: 'หน้าหลัก',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 36),
                  child: Image.asset(
                    'assets/images/frontpage/state.png',
                    width: 22.9,
                    height: 22.9,
                  ),
                ),
                label: 'สถิติ',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/frontpage/add.png',
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 36),
                  child: Image.asset(
                    'assets/images/frontpage/chat.png',
                    width: 22.9,
                    height: 22.9,
                  ),
                ),
                label: 'คุยกับโค้ช',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(top: 36),
                  child: Image.asset(
                    'assets/images/frontpage/more.png',
                    width: 22.9,
                    height: 22.9,
                  ),
                ),
                label: 'เมนู',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
