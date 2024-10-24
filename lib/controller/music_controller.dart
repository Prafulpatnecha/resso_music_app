import 'dart:math';
import 'package:flutter/animation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:get/get.dart';
import 'package:resso_music_app/controller/api_helper.dart';
import 'package:resso_music_app/model/api_music_model.dart';
import 'package:resso_music_app/utils/globle_list.dart';

class MusicController extends GetxController {
  Rx<ApiMusicModel>? apiMusicModel;
  late Rx<ApiMusicModel> saveList;
  RxInt selectIndex = 0.obs;
  var controllerAppBar;
  RxList apiAllCategoryAdd = [].obs;

  MusicController() {
    Random random = Random();
    for (int i = 0; i < playlistCategories.length; i++) {
      apiAllCategoryAdd.add(apiGetMethod(playlistCategories[i] +
          letterMusicList[random.nextInt(letterMusicList.length)]));
    }
  }

  Future<Rx<ApiMusicModel>?> apiGetMethod(String musicTypes) async {
    final jsonMap = await ApiHelper.apiHelper.apiGetMethod(musicTypes);
    apiMusicModel = ApiMusicModel.fromJson(jsonMap).obs;
    return apiMusicModel;
  }
  RxList searchApiModal = [].obs;
  void apiSearchingNewSong(String value)
  {
    searchApiModal.clear();
    searchApiModal.add(apiGetMethod(value));
  }

  // Rx<ApiMusicModel>? streamApi()
  // {
  //   return searchApiModal;
  // }

  //Music All Work
  AudioPlayer player = AudioPlayer();
  var duration;

  Future<void> audioPlayPageToPageOnClick() async {
    duration = await player.setUrl(saveList
        .value
        .data
        .results[selectIndex.value]
        .downloadUrl[
            saveList.value.data.results[selectIndex.value].downloadUrl.length -
                1]
        .url!);
    // print(saveList.value.data.results[selectIndex.value].downloadUrl.length);
    player.play();
  }

  void audioPlayAndPause(bool isPlay) {
    if (isPlay) {
      player.play();
    } else {
      player.pause();
    }
  }
  Stream<Duration> sliderPlaySeek()
   {
    return player.positionStream;
  }

  Future<void> musicSetSeek(Duration value)
  async {
    return await player.seek(value);
  }
  Future<void> reStart()
  async {
    selectIndex.value;
    return await audioPlayPageToPageOnClick();
  }
  // RxInt min = 0.obs;
  // RxInt values =0.obs;
}
