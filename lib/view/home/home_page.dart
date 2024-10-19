import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/music_controller.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MusicController musicController = Get.put(MusicController());
    return Scaffold(
      body: Container(
        color: Colors.black,
        // child: FutureBuilder(future: musicController.apiMusicModel.success, builder: (context, snapshot) => Container(),),
      ),
    );
  }
}
