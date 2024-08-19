import 'package:exercies4/common/routes/app_route_name.dart';
import 'package:exercies4/feature/application/view/application.dart';
import 'package:exercies4/feature/auth/view/auth_screen.dart';
import 'package:exercies4/feature/cart/view/cart_screen.dart';
import 'package:exercies4/feature/detail_product/view/detail_product_screen.dart';
import 'package:exercies4/feature/welcome/welcome_screen.dart';
import 'package:exercies4/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final List<RouteEntity> routes = [
    const RouteEntity(name: AppRouteName.welcome, screen: WelcomeScreen()),
    const RouteEntity(name: AppRouteName.auth, screen: AuthScreen()),
    const RouteEntity(name: AppRouteName.application, screen: Application()),
    const RouteEntity(name: AppRouteName.detailProduct, screen: DetailProductScreen()),
    const RouteEntity(name: AppRouteName.cart, screen: CartScreen()),
  ];


  static MaterialPageRoute onGenerateRouteSettings(RouteSettings settings) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    var result =
        routes.where((element) => element.name == settings.name).toList();

    bool deviceFirstTime = Global.storageService.getDeviceFirstOpen();
    bool isLoggedIn = firebaseAuth.currentUser != null;

    if (result[0].name == AppRouteName.welcome) {
      if (deviceFirstTime) {
        return MaterialPageRoute(builder: (ctx) => const WelcomeScreen());
      }
      if (isLoggedIn) {
        return MaterialPageRoute(
          builder: (ctx) => const Application(),
          settings: settings,
        );
      }
      return MaterialPageRoute(
        builder: (ctx) => const AuthScreen(),
        settings: settings,
      );
    } else {
      return MaterialPageRoute(
        builder: (ctx) => result[0].screen,
        settings: settings,
      );
    }
  }
}

class RouteEntity {
  final String name;
  final Widget screen;
  const RouteEntity({required this.name, required this.screen});
}