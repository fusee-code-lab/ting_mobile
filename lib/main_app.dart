import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ting_mobile/core/page_router.dart';

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      debugShowCheckedModeBanner: true,
      home: HomePage(),
      getPages: Get.find<PageRouter<String>>().pages,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageRouter<String>>(
        init: Get.find<PageRouter<String>>(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Ting Mobile", style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.white,
            ),
            body: SafeArea(
              child: IndexedStack(
                index: controller.bottomNavigationIdx,
                children: controller.bottomNavigationPages,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: controller.bottomNavigations,
              currentIndex: controller.bottomNavigationIdx,
              onTap: controller.setBottomNavigationIdx,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.plus_one),
              onPressed: () {
                controller.go("/about");
              },
            ),
          );
        });
  }
}
