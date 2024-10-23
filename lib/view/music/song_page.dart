import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resso_music_app/controller/music_controller.dart';

import '../../contain/play_and_pause.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    MusicController musicController = Get.put(MusicController());
    return Scaffold(
      body: Obx(
        () => CarouselSlider.builder(
            itemCount: musicController.saveList.value.data.results.length,
            options: CarouselOptions(
              initialPage: musicController.selectIndex.value,
              onPageChanged: (index, reason) async {
                if(index!=musicController.selectIndex.value)
                  {
                    musicController.selectIndex.value = index;
                    await musicController.audioPlayPageToPageOnClick();
                  }
              },
              height: h,
              viewportFraction: 2.0,
              enlargeCenterPage: false,
              scrollDirection: Axis.vertical,
            ),
            itemBuilder: (context, index, realIndex) {
              return Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(musicController
                        .saveList
                        .value
                        .data
                        .results[musicController.selectIndex.value]
                        .image[2]
                        .url!),
                    fit: BoxFit.cover,
                    // colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2),BlendMode.colorDodge),
                    opacity: 0.3,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        title: Text(
                          musicController.saveList.value.data
                              .results[musicController.selectIndex.value].name!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 300,
                        width: w * 0.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                          image: DecorationImage(
                            image: NetworkImage(
                              musicController
                                  .saveList
                                  .value
                                  .data
                                  .results[musicController.selectIndex.value]
                                  .image[2]
                                  .url!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      const PlayAndPause(),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     IconButton(
                      //         onPressed: () async {
                      //           try {
                      //             if (0 != musicController.selectIndex.value) {
                      //               musicController.selectIndex.value--;
                      //               await musicController
                      //                   .audioPlayPageToPageOnClick();
                      //             }
                      //           } catch (e) {
                      //             print("Error");
                      //           }
                      //         },
                      //         icon: const Icon(
                      //           Icons.skip_previous,
                      //           color: Colors.white,
                      //           size: 40,
                      //         )),
                      //     IconButton(
                      //         onPressed: () async {
                      //           if (musicController
                      //                       .saveList.value.data.results.length -
                      //                   1 !=
                      //               musicController.selectIndex.value) {
                      //             try {
                      //               musicController.selectIndex.value++;
                      //               await musicController
                      //                   .audioPlayPageToPageOnClick();
                      //             } catch (e) {
                      //               print("Error");
                      //             }
                      //           }
                      //         },
                      //         icon: const Icon(
                      //           Icons.skip_next,
                      //           color: Colors.white,
                      //           size: 40,
                      //         )),
                      //   ],
                      // )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
