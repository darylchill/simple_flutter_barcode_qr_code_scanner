import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class MobilePermissions_Controller {
  final locationStatusValueProvider = StateProvider<bool>((ref) => false);
  final cameraStatusValueProvider = StateProvider<bool>((ref) => false);
  final storageStatusValueProvider = StateProvider<bool>((ref) => false);

  Future<bool> checkLocationPermission(WidgetRef ref) async {
    final locationStatus = ref.watch(locationStatusValueProvider);

    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted;

    bool location = serviceStatusLocation == ServiceStatus.enabled;

    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      ref.read(locationStatusValueProvider.notifier).state = true;
      if (kDebugMode) {
        print('Permission Granted');
      }
    } else if (status == PermissionStatus.denied) {
      ref.read(locationStatusValueProvider.notifier).state = false;
      if (kDebugMode) {
        print('Permission denied');
      }
    } else if (status == PermissionStatus.permanentlyDenied) {
      ref.read(locationStatusValueProvider.notifier).state = false;
      if (kDebugMode) {
        print('Permission Permanently Denied');
      }
      //await openAppSettings();
    }

    return locationStatus;
  }

  Future<bool> checkCameraPermission(WidgetRef ref) async {
    final cameraStatus = ref.watch(cameraStatusValueProvider);
    final serviceStatusCamera = await Permission.camera.isGranted;

    bool isCamera = serviceStatusCamera == ServiceStatus.enabled;

    final status = await Permission.camera.request();

    if (status == PermissionStatus.granted) {
      ref.read(cameraStatusValueProvider.notifier).state = true;
      debugPrint('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      ref.read(cameraStatusValueProvider.notifier).state = false;
      debugPrint('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      ref.read(cameraStatusValueProvider.notifier).state = false;
      debugPrint('Permission Permanently Denied');
      await openAppSettings();
    }

    return cameraStatus;
  }

  Future<bool> checkStoragePermission(WidgetRef ref) async {
    final serviceStatusExternalStorage = await Permission.storage.isGranted;

    final storageStatus = ref.watch(storageStatusValueProvider);

    bool isStorage = serviceStatusExternalStorage == ServiceStatus.enabled;

    final status = await Permission.storage.request();

    if (status == PermissionStatus.granted) {
      ref.read(storageStatusValueProvider.notifier).state = true;
      debugPrint('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      ref.read(storageStatusValueProvider.notifier).state = false;
      debugPrint('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      ref.read(storageStatusValueProvider.notifier).state = false;
      debugPrint('Permission Permanently Denied');
      await openAppSettings();
    }

    return storageStatus;
  }
}
