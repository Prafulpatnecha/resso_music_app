
import 'package:get/get.dart';
import 'package:resso_music_app/controller/api_helper.dart';
import 'package:resso_music_app/model/api_music_model.dart';

class MusicController extends GetxController{
  Rx<ApiMusicModel>? apiMusicModel;
  Rx<ApiMusicModel>? apiMusicModelAddAll;

  MusicController()
  {
    apiGetMethod("Latest");
  }

  Future<Rx<ApiMusicModel>?> apiGetMethod(String musicTypes)
  async {
    final jsonMap = await ApiHelper.apiHelper.apiGetMethod(musicTypes);
    apiMusicModel = ApiMusicModel.fromJson(jsonMap).obs;
    return apiMusicModel;
    // log(apiMusicModel.success.toString());
  }
}