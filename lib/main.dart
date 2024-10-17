import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:resso_music_app/view/home/home_page.dart';


void main()
{
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Resso - Akhil_sir",
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: "/", page:() => const HomePage()),

      ],
    );
  }
}
