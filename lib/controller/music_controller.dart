
import 'package:get/get.dart';
import 'package:resso_music_app/controller/api_helper.dart';
import 'package:resso_music_app/model/api_music_model.dart';

class MusicController extends GetxController{
  Rx<ApiMusicModel>? apiMusicModel;

  MusicController()
  {
    apiGetMethod();
  }

  Future<Rx<ApiMusicModel>?> apiGetMethod()
  async {
    final jsonMap = await ApiHelper.apiHelper.apiGetMethod("Z");
    apiMusicModel = ApiMusicModel.fromJson(jsonMap).obs;
    return apiMusicModel;
    // log(apiMusicModel.success.toString());
  }
}