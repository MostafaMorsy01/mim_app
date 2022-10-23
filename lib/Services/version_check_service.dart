import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/flash_widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../CommonWidget/version_alert_dialog.dart';
import '../Constants/app_constants.dart';
import '../Constants/app_endpoints.dart';
import '../Constants/app_enums.dart';
import '../Localization/app_localization.dart';
import '../Logger/logger.dart';
import '../Models/version_model.dart';

class VersionCheckService with ChangeNotifier {
  Version? version;
  Status status = Status.loading;
  Future<void> checkVersion(BuildContext context) async {
    status = Status.loading;
    notifyListeners();
    try {
      var result = await fetchVersion("token");
      if (result["status"] == 200) {
        logger.d(result['data']);
        version = Version.fromJson(result['data']);

        PackageInfo packageInfo = await PackageInfo.fromPlatform();

        String appName = packageInfo.appName;
        String packageName = packageInfo.packageName;
        String versionNumber = packageInfo.version;
        String buildNumber = packageInfo.buildNumber;

        logger.i(
            "$appName\nPackage Name: $packageName\nVersion Number: $versionNumber\nBuild Number:$buildNumber");

        if (versionNumber != version?.version) {
          showVersionAlertDialog(
              AppConstants.navigatorKey!.currentState!.context,
              version!.isObligatory, () async {
            Uri url = Uri.parse(version!.url);
            await canLaunchUrl(url)
                ? launchUrl(url)
                : FlashWidgets.showErrorBar(
                    context: AppConstants.navigatorKey!.currentState!.context,
                    message: getTranslated(
                        AppConstants.navigatorKey!.currentState!.context,
                        "something_went_wrong"));
          }, () {});
        }
      } else {
        FlashWidgets.showErrorBar(
          context: context,
          message: getTranslated(
              AppConstants.navigatorKey!.currentState!.context,
              "something_went_wrong"),
        );
      }
    } catch (e, stack) {
      logger.e(e, [e, stack]);
      status = Status.failed;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> fetchVersion(
    String token,
  ) async {
    Response? response;
    try {
      String url = EndPoints.baseUrl +
          EndPoints.version +
          (Platform.isIOS ? EndPoints.iOS : EndPoints.android);
      response = await Dio().get(
        url,
        options: Options(
          validateStatus: (_) {
            return true;
          },
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      if (response.statusCode == 200) {
        return {
          "status": response.statusCode,
          "data": response.data,
          "message": "Success",
        };
      } else if (response.statusCode == 400) {
        return {
          "status": response.statusCode,
          "data": null,
          "message": response.data['message'],
        };
      } else if (response.statusCode == 401) {
        return {
          "status": response.statusCode,
          "data": null,
          "message": response.data['message'],
        };
      } else {
        return {
          "status": response.statusCode,
          "data": null,
          "message": response.data['message'],
        };
      }
    } catch (error) {
      return {
        "status": response?.statusCode,
        "data": null,
        "message": response?.data['message'],
      };
    }
  }
}
