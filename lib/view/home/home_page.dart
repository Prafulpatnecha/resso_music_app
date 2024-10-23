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
    Random random = Random();
    MusicController musicController = Get.put(MusicController());
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;
    int xIndex = random.nextInt(playlistCategories.length);
    int yIndex = random.nextInt(playlistCategories.length);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              // color: Colors.blue.withOpacity(0.0),
              height: h,
              width: w,
              child: StreamBuilder(
                  stream: Connectivity().onConnectivityChanged,
                  builder: (context, snapshots) {
                    try {
                      if (!snapshots.data!
                              .contains(ConnectivityResult.mobile) &&
                          !snapshots.data!.contains(ConnectivityResult.wifi)) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshots.hasError) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return SingleChildScrollView(
                        controller: musicController.controllerAppBar,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: SweepGradient(
                                  colors: [
                                    // Colors.white.withOpacity(0.5),
                                    // Colors.transparent.withOpacity(0.2),
                                    // Colors.transparent,
                                    Colors.blue.shade500.withOpacity(0.15),
                                    Colors.transparent,
                                    Colors.red.withOpacity(0.15),
                                    Colors.transparent,
                                    // Colors.transparent,
                                    // Colors.white.withOpacity(0.5)
                                  ],
                                  center: Alignment(-0.12, 0.65),
                                ),
                              ),
                              child: Column(
                                children: [
                                  AppBar(
                                    centerTitle: true,
                                    actions:  [
                                        Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: AssetImage("assets/logo/resso.png"))
                                          ),
                                        ),
                                      SizedBox(width: 20,)
                                      ],
                                    title: Text(
                                      "Resso",
                                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Welcome ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30),
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "To",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ).paddingSymmetric(horizontal: 20),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Spacer(),
                                      Spacer(),
                                      const Text(
                                        "Your Best New Resso Music",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                            ),
                            ...List.generate(
                              playlistCategories.length,
                              (index) {
                                var musicShareSave =
                                    musicController.apiAllCategoryAdd[index];
                                try {
                                  return FutureBuilder(
                                    future: musicShareSave,
                                    builder: (context, snapshot) {
                                      Rx<ApiMusicModel>? apiMusicModel =
                                          snapshot.data as Rx<ApiMusicModel>?;
                                      if (snapshot.hasError) {
                                        return Center(
                                          child:
                                              Text(snapshot.error.toString()),
                                        );
                                      }
                                      if (snapshot.hasData) {
                                        return (apiMusicModel!
                                                .value.data.results.isNotEmpty)
                                            ? Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        playlistCategories[
                                                            index],
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ).paddingSymmetric(
                                                          vertical: 15,
                                                          horizontal: 5),
                                                      // IconButton(onPressed: () {
                                                      //
                                                      // }, icon: Icon(Icons.arrow_drop_down)),
                                                    ],
                                                  ),
                                                  (apiMusicModel.value.data.results.length>4)?SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        ...List.generate(
                                                          apiMusicModel
                                                              .value
                                                              .data
                                                              .results
                                                              .length,
                                                          (indexs) {
                                                            return Column(
                                                              children: [
                                                                Container(
                                                                  height: 120,
                                                                  width: 120,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(20),
                                                                      color: Colors
                                                                          .blue,
                                                                      image: DecorationImage(
                                                                          image: NetworkImage((apiMusicModel.value.data.results[indexs].image[2].url != null)
                                                                              ? apiMusicModel.value.data.results[indexs].image[2].url!
                                                                              : "https://www.vanessa-hopkins.com/wp-content/uploads/2022/11/Untitled-4-01.png"),
                                                                          fit: BoxFit.cover)),
                                                                ).paddingSymmetric(
                                                                    horizontal:
                                                                        10),
                                                                Container(
                                                                    width: 115,
                                                                    child: Text(apiMusicModel.value.data.results[indexs].name!,textAlign: TextAlign.center,style: TextStyle(color: Colors.white.withOpacity(0.6)),overflow: TextOverflow.ellipsis,)).paddingSymmetric(vertical: 5)
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ):SingleChildScrollView(
                                                    // scrollDirection:
                                                    // Axis.horizontal,
                                                    child: Column(
                                                      children: [
                                                        ...List.generate(
                                                          apiMusicModel
                                                              .value
                                                              .data
                                                              .results
                                                              .length,
                                                              (indexs) {
                                                            return ListTile(
                                                              onTap: () async {
                                                                //Todo select Music Index,And All Music List
                                                                try{
                                                                if(musicController.saveList.value.success==null || musicController.saveList.value.data.results[musicController.selectIndex.value].downloadUrl[musicController.saveList.value.data.results[indexs].downloadUrl.length-1].url!=apiMusicModel.value.data.results[indexs].downloadUrl[apiMusicModel.value.data.results[indexs].downloadUrl.length-1].url)
                                                                  {
                                                                    musicController.saveList = apiMusicModel;
                                                                    musicController.selectIndex = indexs.obs;
                                                                    await musicController.audioPlayPageToPageOnClick();
                                                                  }
                                                                }catch(e)
                                                                {
                                                                  musicController.saveList = apiMusicModel;
                                                                  musicController.selectIndex = indexs.obs;
                                                                  await musicController.audioPlayPageToPageOnClick();
                                                                }
                                                                Get.toNamed("/song");
                                                              },
                                                              leading: Container(
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage((apiMusicModel.value.data.results[indexs].image[2].url != null)
                                                                    ? apiMusicModel.value.data.results[indexs].image[2].url!
                                                                    : "https://www.vanessa-hopkins.com/wp-content/uploads/2022/11/Untitled-4-01.png"),)),
                                                              ),
                                                              trailing: Icon(Icons.navigate_next_outlined),
                                                              title: Text(apiMusicModel.value.data.results[indexs].name.toString(),style: TextStyle(color: Colors.white.withOpacity(0.7),),overflow: TextOverflow.ellipsis,),
                                                              subtitle: Text(apiMusicModel.value.data.results[indexs].artists.primary[0].name.toString(),style: TextStyle(color: Colors.white.withOpacity(0.3)),overflow: TextOverflow.ellipsis,),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ).paddingAll(5)
                                            : Container();
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  );
                                } catch (e) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            // (index==)?
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Colors.blue.withOpacity(0.05),
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("Resso",style: TextStyle(color: Colors.red.withOpacity(0.8),fontWeight: FontWeight.bold,fontSize: 15),),
                            )
                          ],
                        ),
                      );
                    } catch (e) {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
