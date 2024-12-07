import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/data/constants/constants.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: Constants.appName,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        useMaterial3: false,
      ),
    ),
  );
}
