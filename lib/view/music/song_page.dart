import 'dart:async';

import 'package:card_loading/card_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:resso_music_app/controller/music_controller.dart';

import '../../contain/play_and_pause.dart';
import '../home/home_page.dart';

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
                try {
                  if (index != musicController.selectIndex.value) {
                    musicController.selectIndex.value = index;
                    await musicController.audioPlayPageToPageOnClick();
                  }
                } catch (e) {
                  print("Error");
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
                    children: [
                      AppBar(
                        leading: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.navigate_before,
                              color: Colors.white,
                            )),
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
                          // color: Colors.blue,
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
                            opacity: 0.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 150,
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
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: w,
                        child: StreamBuilder(
                            stream: musicController.sliderPlaySeek(),
                            builder: (context, snapshot) {
                              try {
                                var data = snapshot.data!;
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CardLoading(
                                        cardLoadingTheme: CardLoadingTheme(colorOne: white, colorTwo: black),
                                        height: 20,
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        margin: EdgeInsets.only(bottom: 10),
                                      ).paddingSymmetric(horizontal: 20));
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: CardLoading(
                                      cardLoadingTheme: CardLoadingTheme(colorOne: white, colorTwo: black),
                                      height: 20,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      margin: EdgeInsets.only(bottom: 10),
                                    ).paddingSymmetric(horizontal: 20),
                                  );
                                } else {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        musicController
                                                .player.duration!.inSeconds
                                                .toString() ??
                                            "0",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Slider(
                                        overlayColor: WidgetStatePropertyAll(
                                            Colors.blue.withOpacity(0.2)),
                                        thumbColor: Colors.red.withOpacity(0.2),
                                        activeColor:
                                            Colors.red.withOpacity(0.2),
                                        inactiveColor:
                                            Colors.blue.withOpacity(0.2),
                                        // secondaryActiveColor: Colors.blue.withOpacity(0.2),
                                        max: musicController.duration.inSeconds
                                                .toDouble() ??
                                            0,
                                        // min: 0,
                                        value: data.inSeconds.toDouble(),
                                        onChanged: (value) async {
                                          musicController.musicSetSeek(
                                              Duration(seconds: value.toInt()));
                                        },
                                      ),
                                      Text(
                                        data.inSeconds.toString() ?? "0",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  );
                                }
                              } catch (e) {
                                // musicController.reStart();
                                return CardLoading(
                                  cardLoadingTheme: CardLoadingTheme(colorOne: white, colorTwo: black),
                                  height: 20,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  margin: EdgeInsets.only(bottom: 10),
                                ).paddingSymmetric(horizontal: 20);
                              }
                            }),
                      ),
                      // Container(
                      //   height: 50,
                      //   width: w,
                      //   child: StreamBuilder(
                      //       stream: musicController.sliderPlaySeek(),
                      //       builder: (context, snapshot) {
                      //         try {
                      //           var data = snapshot.data!;
                      //           if (!snapshot.hasData) {
                      //             return const Center(
                      //                 child: CircularProgressIndicator());
                      //           } else if (snapshot.hasError) {
                      //             return Center(
                      //               child: CircularProgressIndicator(),
                      //             );
                      //           } else {
                      //             return Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(data.inSeconds.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                      //                 Text(musicController.player.duration!.inSeconds.toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                      //               ],
                      //             ).paddingSymmetric(horizontal: 30);
                      //
                      //             //   Slider(
                      //             //   overlayColor: WidgetStatePropertyAll(
                      //             //       Colors.blue.withOpacity(0.2)),
                      //             //   thumbColor: Colors.red.withOpacity(0.2),
                      //             //   activeColor: Colors.red.withOpacity(0.2),
                      //             //   inactiveColor: Colors.blue.withOpacity(0.2),
                      //             //   // secondaryActiveColor: Colors.blue.withOpacity(0.2),
                      //             //   max: musicController.duration.inSeconds
                      //             //       .toDouble() ??
                      //             //       0,
                      //             //   // min: 0,
                      //             //   value: data.inSeconds.toDouble(),
                      //             //   onChanged: (value) async {
                      //             //     musicController.musicSetSeek(
                      //             //         Duration(seconds: value.toInt()));
                      //             //   },
                      //             // );
                      //           }
                      //         } catch (e) {
                      //           print("error");
                      //         }
                      //         musicController.reStart();
                      //         return CircularProgressIndicator();
                      //       }),
                      // ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
