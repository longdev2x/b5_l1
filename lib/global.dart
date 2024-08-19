import 'package:exercies4/common/data/local/shared_preferences_helper.dart';
import 'package:exercies4/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Global {
  static late final SharedPreferencesHelper storageService;
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    storageService = await SharedPreferencesHelper().init();
  }
}
