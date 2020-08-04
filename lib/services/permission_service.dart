
import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Permission _permission;
  PermissionStatus _permissionStatus = PermissionStatus.undetermined;

  Future<void> checkStatus()async {
      final status = await _permission.status;
      _permissionStatus = status;
      return _permissionStatus;

  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    _permissionStatus = status;
    return _permissionStatus;
  }
}