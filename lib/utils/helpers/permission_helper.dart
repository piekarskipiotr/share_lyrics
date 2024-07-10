import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<void> check(Permission permission, VoidCallback onSuccess) async {
    final status = await permission.status;
    switch (status) {
      case PermissionStatus.granted: onSuccess.call();
      case PermissionStatus.permanentlyDenied: await openAppSettings();
      case _: break;
    }
  }
}
