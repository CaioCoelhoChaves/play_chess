import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'app/config/app_config.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Play chess',
    debugShowCheckedModeBanner: AppConfig.debugMode,
    initialRoute: AppPages.initialRoute,
    getPages: AppPages.pages,
  ));
}




