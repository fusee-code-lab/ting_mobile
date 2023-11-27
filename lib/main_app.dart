import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ting_mobile/core/page_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      debugShowCheckedModeBanner: true,
      home: const HomePage(),
      getPages: Get.find<PageRouter<String>>().pages,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PageRouter<String>>(
        init: Get.find<PageRouter<String>>(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Ting Mobile",
                  style: TextStyle(color: Colors.black)),
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
              child: const Icon(Icons.plus_one),
              onPressed: () {
                controller.go("/about");
              },
            ),
          );
        });
  }
}
