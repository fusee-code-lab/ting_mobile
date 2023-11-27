import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef WidgetLinkedMap<Key> = Map<Key, RouteItem>;

enum RouteType { page, bottomNavigation }

class RouteItem {
  final GetPageBuilder builder;
  final RouteType type;
  final Widget? icon;
  final Widget? activeIcon;
  final String? label;
  final Transition? transition;

  RouteItem(this.builder,
      {RouteType type = RouteType.page,
      this.icon,
      this.activeIcon,
      this.label,
      this.transition})
      : this.type = type;
}

abstract class BasePageRouter<RouteKey> {
  /// 跳转 tab 标签
  void goToTab(RouteKey target);

  /// 跳转页面
  void go(RouteKey target);
}

class PageRouter<RouteKey> extends GetxController
    with SingleGetTickerProviderMixin
    implements BasePageRouter<RouteKey> {
  final _bottomNavigationIdx = 0.obs;
  final List<Widget> bottomNavigationPages = [];
  final List<BottomNavigationBarItem> bottomNavigations = [];
  final List<GetPage> pages = [];
  final RouteKey? _initialRoute;
  final WidgetLinkedMap<RouteKey> routes;
  String get initialRoute => _initialRoute.toString();
  final Map<RouteKey, int> _bottomRouteKeyToIdx = {};
  RouteKey _currentRoute;

  int get bottomNavigationIdx => this._bottomNavigationIdx.value;
  void setBottomNavigationIdx(int idx) {
    this._bottomNavigationIdx.value = idx;
    super.update();
  }

  PageRouter.defineRoutes(
      {required RouteKey initialRoute, required this.routes})
      : _initialRoute = initialRoute,
        _currentRoute = initialRoute,
        assert(
            routes.keys.contains(initialRoute), "initialRoute 必须定义在 routes 中") {
    var bottomNavigationCount = 0;
    for (var entry in routes.entries) {
      if (entry.value.type == RouteType.bottomNavigation) {
        assert(entry.value.icon != null, "bottomNavigation 导航必须提供 icon");
        assert(entry.value.label != null, "bottomNavigation 导航必须提供 label");

        var bottomNavItem = BottomNavigationBarItem(
          icon: entry.value.icon!,
          activeIcon: entry.value.activeIcon,
          label: entry.value.label!,
        );

        bottomNavigations.add(bottomNavItem);
        bottomNavigationPages.add(entry.value.builder());
        _bottomRouteKeyToIdx[entry.key] = bottomNavigationCount;

        print(bottomNavigationCount);
        bottomNavigationCount++;
        continue;
      }

      if (entry.value.type == RouteType.page) {
        var pageItem = GetPage(
            name: entry.key.toString(),
            page: entry.value.builder,
            transition: entry.value.transition);
        pages.add(pageItem);
      }
    }
  }

  @override
  void goToTab(RouteKey target) {
    assert(this.routes.keys.contains(target), "target 必须定义在 routes");
    assert(this.routes[target]!.type == RouteType.bottomNavigation,
        "goToTab 必须跳转到 bottomNavigation 类型的路由");

    _currentRoute = target;
    var idx = _bottomRouteKeyToIdx[target]!;
    _bottomNavigationIdx.value = idx;
  }

  @override
  void go(RouteKey target) {
    assert(this.routes.keys.contains(target), "target 必须定义在 routes");
    assert(this.routes[target]!.type == RouteType.page,
        "goToTab 必须跳转到 page 类型的路由");

    _currentRoute = target;
    Get.toNamed(target.toString());
  }
}
