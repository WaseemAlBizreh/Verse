import 'package:connectivity_plus/connectivity_plus.dart';

class InternetUtils {
  static final Connectivity _connectivity = Connectivity();

  // Current connection status (true if connected, false if not)
  static bool isConnect = true;

  static Future<void> init() async {
    final List<ConnectivityResult> result = await _connectivity
        .checkConnectivity();
    _updateConnectionStatus(result);
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  static void _updateConnectionStatus(List<ConnectivityResult> result) {
    isConnect = result.any(
      (connectivity) =>
          connectivity == ConnectivityResult.wifi ||
          connectivity == ConnectivityResult.mobile ||
          connectivity == ConnectivityResult.ethernet,
    );
  }

  static bool get isDisconnect {
    if (isConnect) return false;

    // Optionally show toast or handle no internet ui here
    // showErrorToast(message: kInternetNotAvailable);

    return true;
  }

  /// Check if there is internet connection before executing [call]
  static void checkInternet(Function() call) {
    if (isDisconnect) return;
    call();
  }
}
