import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:meem_app/Services/secure_storage_services.dart';

class CommonFunctions {
  static Future<void> cleanBeforeLogout(BuildContext context) async {
    // await FirebaseMessaging.instance.unsubscribeFromTopic("Free");
    // await FirebaseMessaging.instance.unsubscribeFromTopic("Premium");
    await SecureStorageService.deleteAll();
    // await NotificationService.cancelAllNotifications();
    // UserRepository().clear();
    Phoenix.rebirth(context);
  }
}
