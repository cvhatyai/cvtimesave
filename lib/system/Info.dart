final String _base_url = "https://cvtimesave.demo-cv.com/";
final String _base_url_api = _base_url + "app_api_v1";

class Info {
  String baseUrl = _base_url;

  String userLogin = _base_url_api + '/userLogin';
  String insertTime = _base_url_api + '/insertTime';
  String timeDetail = _base_url_api + '/timeDetail';
  String otpOverUse = _base_url_api + '/otpOverUse';
  String checkHasPhone = _base_url_api + '/checkHasPhone';
  String checkOtp = _base_url_api + '/checkOtp';
  String setCannotRequestOtp = _base_url_api + '/setCannotRequestOtp';
  String insertUser = _base_url_api + '/insertUser';
  String updateUserData = _base_url_api + '/updateUserData';
  String checkAppVersion = _base_url_api + '/checkAppVersion';

  Info() : super();
}
