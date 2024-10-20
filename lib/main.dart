import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:resso_music_app/controller/music_controller.dart';
import 'package:resso_music_app/view/home/home_page.dart';


void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  MusicController musicController = Get.put(MusicController());
    return GetMaterialApp(
      title: "Resso - Akhil_sir",
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: "/", page:() => const HomePage()),
      ],
    );
  }
}
