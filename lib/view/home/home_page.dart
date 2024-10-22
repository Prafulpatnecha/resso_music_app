import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resso_music_app/model/api_music_model.dart';
import 'package:resso_music_app/utils/globle_list.dart';

import '../../controller/music_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MusicController musicController = Get.put(MusicController());
    return Scaffold(
      body: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshots) {
            try {
              if (!snapshots.data!.contains(ConnectivityResult.mobile) &&
                  !snapshots.data!.contains(ConnectivityResult.wifi)) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshots.hasError) {
                return const Center(child: CircularProgressIndicator());
              }
              Random random =Random();
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      playlistCategories.length, (index) {
                        return FutureBuilder(
                          future: musicController.apiGetMethod(playlistCategories[index]+" latest"+letterMusicList[random.nextInt(letterMusicList.length)]),
                          builder: (context, snapshot) {
                            ApiMusicModel apiMusicModel = snapshot.data!.value;
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            }
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return (apiMusicModel.data.results.isNotEmpty)?Column(
                              children: [
                                Row(
                                  children: [
                                    Text(playlistCategories[index],style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),).paddingSymmetric(vertical: 15,horizontal: 5),
                                    // IconButton(onPressed: () {
                                    //
                                    // }, icon: Icon(Icons.arrow_drop_down)),
                                  ],
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ...List.generate(apiMusicModel.data.results.length, (indexs) {
                                        return Column(
                                          children: [
                                            Container(
                                              height: 120,
                                              width: 120,
                                              decoration: BoxDecoration(
                                              color: Colors.blue,
                                                  image: DecorationImage(image: NetworkImage((apiMusicModel.data.results[indexs].image[2].url!=null)?apiMusicModel.data.results[indexs].image[2].url!:"https://www.vanessa-hopkins.com/wp-content/uploads/2022/11/Untitled-4-01.png"),fit: BoxFit.cover)
                                              ),
                                            ).paddingSymmetric(horizontal: 10),
                                          ],
                                        );
                                      },),
                                    ],
                                  ),
                                ),
                              ],
                            ).paddingAll(5):Container();
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            } catch (e) {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
