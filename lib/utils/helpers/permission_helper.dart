import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<void> check({
    required Permission permission,
    required VoidCallback onSuccess,
    VoidCallback? onPermanentlyDenied,
  }) async {
    final status = await permission.status;
    switch (status) {
      case PermissionStatus.granted:
        onSuccess.call();
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
        onPermanentlyDenied == null ? await openAppSettings() : onPermanentlyDenied.call();
      case _:
        break;
    }
  }
}
