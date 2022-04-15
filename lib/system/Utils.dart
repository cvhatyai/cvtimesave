import 'dart:convert';
import 'package:cvtimesave/system/user.dart';
import 'package:http/http.dart' as http;

import 'Info.dart';

class Utils {
  var user = User();

  userInit() async {
    await user.init();
  }

  userLogin(username, password) async {
    Map _map = {};
    _map.addAll({
      "username": username,
      "password": password,
    });
    var body = json.encode(_map);
    return postUserLogin(http.Client(), body, _map);
  }

  postUserLogin(http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().userLogin), headers: {"Content-Type": "application/json"}, body: jsonMap);
    return json.decode(response.body);
  }

  insertTime(hr, minute) async {
    await userInit();
    Map _map = {};
    _map.addAll({
      "hr": hr,
      "minute": minute,
      "uid": user.uid,
    });
    var body = json.encode(_map);
    return postInsertTime(http.Client(), body, _map);
  }

  postInsertTime(http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().insertTime), headers: {"Content-Type": "application/json"}, body: jsonMap);
    return json.decode(response.body);
  }
}
