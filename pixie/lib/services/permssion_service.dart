import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService extends GetxService {
  Future<PermissionStatus> requestPermissions() async {
    var status = await Permission.manageExternalStorage.request();

    if (status == PermissionStatus.denied) {
      print('Permission is denied, request again');
      status = await Permission.manageExternalStorage.request();
    } if (status == PermissionStatus.granted) {
      print('Permission granted');
      return status;
    } if (status == PermissionStatus.permanentlyDenied) {
      print('Permission is permanently denied, grant from settings');
      openAppSettings();
    }
    return status;
  }
}