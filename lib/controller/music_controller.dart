
import 'package:resso_music_app/controller/api_helper.dart';
import 'package:resso_music_app/model/api_music_model.dart';

class MusicController {
  MusicController()
  {
    apiGetMethod();
  }
  late ApiMusicModel apiMusicModel;

  void apiGetMethod()
  async {

    apiMusicModel = ApiHelper.apiHelper.apiGetMethod("Z") as ApiMusicModel;
    // log(apiMusicModel.success.toString());
  }
}