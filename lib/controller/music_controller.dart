import 'dart:math';

import 'package:get/get.dart';
import 'package:resso_music_app/controller/api_helper.dart';
import 'package:resso_music_app/model/api_music_model.dart';
import 'package:resso_music_app/utils/globle_list.dart';

class MusicController extends GetxController {
  Rx<ApiMusicModel>? apiMusicModel;
  late ApiMusicModel saveList;
  // Rx<ApiMusicModel>? apiMusicModelAddAll;
  RxList apiAllCategoryAdd = [].obs;

  MusicController() {
    Random random =Random();
    for (int i = 0; i < playlistCategories.length; i++) {
      apiAllCategoryAdd.add(apiGetMethod(playlistCategories[i]+letterMusicList[random.nextInt(letterMusicList.length)]));
      // print(apiAllCategoryAdd[i]);
    }
    // apiAllCategoryAdd!.map((data) => apiMusicModel!,).toList();
    // apiGetMethod("Latest");
  }

  Future<Rx<ApiMusicModel>?> apiGetMethod(String musicTypes) async {
    final jsonMap = await ApiHelper.apiHelper.apiGetMethod(musicTypes);
    apiMusicModel = ApiMusicModel.fromJson(jsonMap).obs;
    // apiAllCategoryAdd = AddingAllMusicListModel;
    return apiMusicModel;
    // log(apiMusicModel.success.toString());
  }
}
