import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resso_music_app/controller/music_controller.dart';

class PlayAndPause extends StatefulWidget {
  const PlayAndPause({super.key});

  @override
  State<PlayAndPause> createState() => _PlayAndPauseState();
}

class _PlayAndPauseState extends State<PlayAndPause>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isPlay = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MusicController musicController = Get.put(MusicController());
    return TextButton(
      onPressed: () {
        if(isPlay)
          {
            controller.forward();
            isPlay =false;
            musicController.audioPlayAndPause(isPlay);
          }else{
          controller.reverse();
          isPlay = true;
          musicController.audioPlayAndPause(isPlay);
        }
      },
      child: AnimatedIcon(
        icon: AnimatedIcons.pause_play,
        progress: controller,
        size: 60.0,
        color: Colors.grey,
        semanticLabel: "Play Pause",
      ),
    );
  }
}
