import 'package:permission_handler/permission_handler.dart';

import '../common/configs/permission.dart';

class PermissionService {
  static Future reqAllPermissions() async {
    return await Future.forEach(
      kPermissions,
          (Permission element) async {
        return await element.request();
      },
    );
  }

  static Future reqPermissions(Permission permission) async {
    return permission.request();
  }

  static Future checkPermission(Permission permission) async {
    return permission.status;
  }

  Future checkLocationService() async {
    return await Permission.location.serviceStatus;
  }

  static Future openSettings() async {
    return openAppSettings();
  }

}