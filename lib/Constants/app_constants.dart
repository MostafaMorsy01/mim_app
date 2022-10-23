import 'package:flutter/material.dart';
import 'package:meem_app/Services/network_service.dart';

class AppConstants {
  static String locale = "ar";
  static String? notificationData;
  static bool? isGuest;
  static NetworkStatus networkStatus = NetworkStatus.online;
  static GlobalKey<NavigatorState>? navigatorKey;
}
