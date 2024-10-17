

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();
  String musicUrl = "https://saavn.dev/api/search/songs?query=";
  Future<void> apiGetMethod(String search)
  async {
    Response response = await http.get(Uri.parse(musicUrl+search));
  }
}