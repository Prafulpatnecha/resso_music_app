import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resso_music_app/model/api_music_model.dart';

import '../../controller/music_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MusicController musicController = Get.put(MusicController());
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: FutureBuilder(
          future: musicController.apiGetMethod(),
          builder: (context, snapshot) {
            musicController.apiMusicModel = snapshot.data;
            if(snapshot.hasError)
              {
                return Center(child: Text(snapshot.error.toString()),);
              }
            if(!snapshot.hasData)
              {
                return const Center(child: CircularProgressIndicator(),);
              }
            return Center(
              child: Container(
                child: Text(musicController.apiMusicModel!.value.success.toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}