import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class CommonMethods {
  checkConnectivity(BuildContext context) async {
    var connectionResult = await Connectivity().checkConnectivity();

    // ignore: unrelated_type_equality_checks
    if (connectionResult != ConnectivityResult.mobile &&
        // ignore: unrelated_type_equality_checks
        connectionResult != ConnectivityResult.wifi) {
      if (!context.mounted) return;
      displaySnackBar("Please wait...", context);
    }
  }

  displaySnackBar(String messageText, BuildContext context) {
    var snackBar = SnackBar(content: Text(messageText));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
