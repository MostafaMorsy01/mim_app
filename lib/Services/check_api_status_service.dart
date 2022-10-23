import 'package:flutter/material.dart';
import 'package:meem_app/CommonWidget/flash_widgets.dart';
import 'package:meem_app/Constants/app_api_status.dart';
import 'package:meem_app/Models/api_response_model.dart';

bool checkStatusCode(BuildContext context, APIResponse response) {
  int statusCode = response.status;
  String? message = response.message;
  switch (statusCode) {
    case AppAPIStatus.okStatus:
      return true;
    case AppAPIStatus.createdStatus:
      return true;
    case AppAPIStatus.acceptedStatus:
      return true;
    case AppAPIStatus.badRequestStatus:
      String toDisplay = message ?? "Bad Request";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.unauthorizedStatus:
      String toDisplay = message ?? "Unauthorized";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      //TODO: ADD CLEAN BEFORE LOGOUT
      //CommonFunctions.cleanBeforeLogout(context);
      break;
    case AppAPIStatus.forbiddenStatus:
      String toDisplay = message ?? "Forbidden";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      //TODO: ADD CLEAN BEFORE LOGOUT
      //CommonFunctions.cleanBeforeLogout(context);
      break;
    case AppAPIStatus.notFoundStatus:
      String toDisplay = message ?? "Not Found";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.methodNotAllowedStatus:
      String toDisplay = message ?? "Method Not Allowed";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.notAcceptedStatus:
      String toDisplay = message ?? "Not Accepted";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.proxyAuthenticationRequiredStatus:
      String toDisplay = message ?? "Proxy Authentication Required";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.requestTimeoutStatus:
      String toDisplay = message ?? "Request Timeout";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.contentTooLargeStatus:
      String toDisplay = message ?? "Content Too Large";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.uriTooLongStatus:
      String toDisplay = message ?? "URI Too Long";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.unsupportedMediaTypeStatus:
      String toDisplay = message ?? "Unsupported Media Types";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.tooManyRequestsStatus:
      String toDisplay = message ?? "Too Many Requests";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.requestHeaderTooLargeStatus:
      String toDisplay = message ?? "Request Header Too Large";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.internalServerErrorStatus:
      String toDisplay = message ?? "Internal Server Error";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.notImplementedStatus:
      String toDisplay = message ?? "Not Implemented";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.badGatewayStatus:
      String toDisplay = message ?? "Bad Gateway";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.serviceUnavailableStatus:
      String toDisplay = message ?? "Service Unavailable";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    case AppAPIStatus.gatewayTimeoutStatus:
      String toDisplay = message ?? "Gateway Timeout";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
    default:
      String toDisplay = message ?? "Something Went Wrong";
      FlashWidgets.showErrorBar(
          context: context, message: "Error $statusCode:\n$toDisplay");
      break;
  }
  return false;
}
