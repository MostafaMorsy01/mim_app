import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import '../Constants/app_constants.dart';

enum NetworkStatus { online, offline }

class NetworkStatusService {
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatusService() {
    Connectivity().onConnectivityChanged.listen((status) {
      AppConstants.networkStatus = getNetworkStatus(status);
      networkStatusController.add(getNetworkStatus(status));
    });
  }

  static NetworkStatus getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }
}
