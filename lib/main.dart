import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:ting_mobile/main_app.dart';
import 'package:ting_mobile/routes.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(buildRouter());
  }
}

void main() {
  MainBinding().dependencies();
  runApp(MainApp());
}