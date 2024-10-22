import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resso_music_app/controller/music_controller.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    MusicController musicController = Get.put(MusicController());
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(musicController.saveList.value.data
                .results[musicController.selectIndex.value].image[2].url!),
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2),BlendMode.colorDodge),
            opacity: 0.3,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 300,
              width: w * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
                image: DecorationImage(
                  image: NetworkImage(musicController
                      .saveList
                      .value
                      .data
                      .results[musicController.selectIndex.value]
                      .image[2]
                      .url!),
                  fit: BoxFit.cover,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
