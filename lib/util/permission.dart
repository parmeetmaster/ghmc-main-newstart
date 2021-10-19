import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static bool is_camera_enable = false;
  static bool is_location_enable = false;
  static bool is_storage_enable = false;
  static bool is_notification_enable = false;

  initialisationPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
      Permission.storage,
      Permission.notification
    ].request();

    is_camera_enable = statuses[Permission.camera]!.isGranted;
    is_location_enable = statuses[Permission.location]!.isGranted;
    is_storage_enable = statuses[Permission.storage]!.isGranted;
    is_notification_enable = statuses[Permission.notification]!.isGranted;
  }

  bool isCameraEnable() {
    return is_camera_enable;
  }

  bool isLocationEnable() {
    return is_camera_enable;
  }

  bool isStorageEnable() {
    return is_storage_enable;
  }

  bool isNotificationEnable() {
    return is_notification_enable;
  }
}
