import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MobilePermissions_Controller extends GetxController{
  var locationStatusValue = false.obs;
  var cameraStatusValue = false.obs;
  var storageStatusValue = false.obs;


  get locationStatus => locationStatusValue.value;
  get cameraStatus => cameraStatusValue.value;
  get storageStatus => storageStatusValue.value;

  Future<bool> checkLocationPermission() async {

    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted ;

    bool location = serviceStatusLocation == ServiceStatus.enabled;

    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      locationStatusValue.value = true;
      if (kDebugMode) {
        print('Permission Granted');
      }
    } else if (status == PermissionStatus.denied) {
      locationStatusValue.value =false;
      if (kDebugMode) {
        print('Permission denied');
      }
    } else if (status == PermissionStatus.permanentlyDenied) {
      locationStatusValue.value =false;
      if (kDebugMode) {
        print('Permission Permanently Denied');
      }
      //await openAppSettings();
    }
    update();

    return locationStatusValue.value;
  }

  Future<void> checkCameraPermission() async {
    final serviceStatusCamera = await Permission.camera.isGranted ;

    bool isCamera = serviceStatusCamera == ServiceStatus.enabled;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  Future<void> checkStoragePermission() async {
    final serviceStatusExternalStorage = await Permission.storage.isGranted ;

    bool isStorage = serviceStatusExternalStorage == ServiceStatus.enabled;

    final status = await Permission.storage.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }







}