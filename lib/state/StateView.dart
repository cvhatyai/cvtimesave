import 'package:flutter/material.dart';

class StateView extends StatefulWidget {
  const StateView({Key? key}) : super(key: key);

  @override
  _StateViewState createState() => _StateViewState();
}

class _StateViewState extends State<StateView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Center(
          child: Text("Coming Soon..."),
        ),
      ),
    );
  }
}
