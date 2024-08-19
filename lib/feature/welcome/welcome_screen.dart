import 'dart:async';

import 'package:exercies4/common/routes/app_route_name.dart';
import 'package:exercies4/common/utils/app_constants.dart';
import 'package:exercies4/global.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouteName.auth,
          (route) => false,
        );
        await Global.storageService.setBool(AppConstants.keyFirstDevice, false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome Screen'),
      ),
    );
  }
}
