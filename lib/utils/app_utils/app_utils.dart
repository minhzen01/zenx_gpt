import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppUtils {
  static late Size mq;

  /// UI overlay background color transparent.
  static void systemUIOverlayTrans() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }

  /// Only in portrait mode.
  static Future<void> portraitPreferredOrientations() async {
    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }

  /// UI mode fullscreen.
  /// Hide all UI overlay.
  static Future<void> systemUIModeFullScreen() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  /// show UI overlay.
  static void enabledSystemUIMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}