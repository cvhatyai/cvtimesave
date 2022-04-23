import 'dart:convert';
import 'package:cvtimesave/system/user.dart';
import 'package:http/http.dart' as http;

import 'Info.dart';

class Utils {
  var user = User();

  userInit() async {
    await user.init();
  }

  userLogin(username) async {
    Map _map = {};
    _map.addAll({
      "username": username,
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

  timeDetail(uid) async {
    Map _map = {};
    _map.addAll({
      "uid": uid,
    });
    var body = json.encode(_map);
    return postTimeDetail(http.Client(), body, _map);
  }

  postTimeDetail(http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().timeDetail), headers: {"Content-Type": "application/json"}, body: jsonMap);
    return json.decode(response.body);
  }

  setCannotRequestOtp(username) async {
    Map _map = {};
    _map.addAll({
      "username": username,
    });
    var body = json.encode(_map);
    return postSetCannotRequestOtp(http.Client(), body, _map);
  }

  postSetCannotRequestOtp(http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().setCannotRequestOtp), headers: {"Content-Type": "application/json"}, body: jsonMap);
    return json.decode(response.body);
  }

  updateUserData(uid, _fullname, _schoolClass, _schoolName, _goal) async {
    Map _map = {};
    _map.addAll({
      "uid": uid,
      "fullname": _fullname,
      "schoolClass": _schoolClass,
      "schoolName": _schoolName,
      "goal": _goal,
    });
    var body = json.encode(_map);
    final client = http.Client();
    final response = await client.post(Uri.parse(Info().updateUserData), headers: {"Content-Type": "application/json"}, body: body);
    return json.decode(response.body);
  }

  checkAppData(platform, version) async {
    Map _map = {};
    _map.addAll({
      "platform": platform,
      "version": version,
    });
    var body = json.encode(_map);
    final client = http.Client();
    final response = await client.post(Uri.parse(Info().checkAppVersion), headers: {"Content-Type": "application/json"}, body: body);
    return json.decode(response.body);
  }

}
