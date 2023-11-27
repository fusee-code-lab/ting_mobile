import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ting_mobile/pages/about_page/about_page.dart';
import 'package:ting_mobile/pages/hello_page/hello_page.dart';
import 'package:ting_mobile/pages/search_page/search_page.dart';

import 'core/page_router.dart';

PageRouter<String> buildRouter() {
  return PageRouter.defineRoutes(initialRoute: "/hello", routes: {
    "/hello": RouteItem(() => const HelloPage(),
        icon: const Icon(Icons.message),
        label: "hello",
        type: RouteType.bottomNavigation),
    "/search": RouteItem(() => const SearchPage(),
        icon: const Icon(Icons.search),
        label: "search",
        type: RouteType.bottomNavigation),
    "/about": RouteItem(() => const AboutPage(), transition: Transition.fadeIn),
  });
}
