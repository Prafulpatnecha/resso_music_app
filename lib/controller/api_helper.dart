

import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:resso_music_app/model/api_music_model.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();
  String musicUrl = "https://saavn.dev/api/search/songs?query=";
  Future<Object> apiGetMethod(String search)
  async {
    Response response = await http.get(Uri.parse(musicUrl+search));
    if(response.statusCode == 200)
      {
        return ApiMusicModel.fromJson(jsonDecode(response.body));
      }else{
      return {};
    }
  }
}