import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'constant/get_pages.dart';
import 'constant/routes.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
            primaryColor: Colors.green
        ),
        title: 'Flutter App',
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesConstant.loginPage,
        getPages: getPage);
  }
}