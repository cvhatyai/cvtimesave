final String _base_url = "http://cvtimesave.demo-cv.com/";
final String _base_url_api = _base_url + "app_api_v1";

class Info {
  String baseUrl = _base_url;

  String userLogin = _base_url_api + '/userLogin';
  String insertTime = _base_url_api + '/insertTime';

  Info() : super();
}
