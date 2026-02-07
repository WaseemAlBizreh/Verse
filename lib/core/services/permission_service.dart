import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';
import '../ui/resources/asset_manger.dart';
import '../ui/resources/color_manager.dart';
import '../ui/resources/font_manager.dart';
import '../ui/resources/values_manager.dart';

@singleton
class PermissionService {
  Future<bool> checkPhotoPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        return await _checkStoragePermission();
      } else {
        return await _checkPhotosPermission();
      }
    } else {
      return await _checkPhotosPermission();
    }
  }

  Future<bool> _checkStoragePermission() async {
    if (!(await Permission.storage.isGranted)) {
      var status = await Permission.storage.request();
      if (status != PermissionStatus.granted) {
        final context = MyApp.appContext;
        if (context != null) {
          _PermissionDialog(
            content: 'request_permission_images_description'.tr(),
          ).show();
        }
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  Future<bool> _checkPhotosPermission() async {
    if (!(await Permission.photos.isGranted)) {
      var status = await Permission.photos.request();
      if (status != PermissionStatus.granted) {
        final context = MyApp.appContext;
        if (context != null) {
          _PermissionDialog(
            content: 'request_permission_images_description'.tr(),
          ).show();
        }
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  Future<bool> checkCameraPermission() async {
    if (!(await Permission.camera.isGranted)) {
      var status = await Permission.camera.request();
      if (status != PermissionStatus.granted) {
        final context = MyApp.appContext;
        if (context != null) {
          _PermissionDialog(
            content: 'request_permission_camera_description'.tr(),
          ).show();
        }
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  /*Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }*/

  /*Future<bool> checkLocationServiceAndPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return checkLocationServiceAndPermission();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      await _PermissionDialog(
        content: 'request_permission_location_description'.tr(),
      ).show();

      return false;
    }

    return true;
  }*/

  /*Future<Position?> getCurrentLocation() async {
    try {
      bool hasPermission = await checkLocationServiceAndPermission();
      if (!hasPermission) {
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
      return position;
    } catch (e) {
      return null;
    }
  }*/

  Future<void> checkPermissionsOnStartup() async {
    await checkCameraPermission();
    await checkPhotoPermission();
  }

  /*Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }*/
}

class _PermissionDialog {
  final String content;

  _PermissionDialog({required this.content});

  Future<void> show() {
    return showDialog(
      context: MyApp.appContext!,
      builder: (ctx) {
        return AlertDialog(
          elevation: 0,
          title: Column(
            children: [
              SvgPicture.asset(
                IconsAssets.alertCircleIcon,
                colorFilter: ColorFilter.mode(
                  ColorManager.colorOrange,
                  BlendMode.srcIn,
                ),
                width: AppSize.sWidth * 0.2,
              ),
              SizedBox(height: AppSize.s20),
              Text(
                textAlign: TextAlign.start,
                'permission_required'.tr(),
                style: Theme.of(MyApp.appContext!).textTheme.headlineSmall!
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize.s18,
                    ),
              ),
            ],
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
            style: Theme.of(MyApp.appContext!).textTheme.bodySmall!.copyWith(
              color: ColorManager.colorFontPrimary,
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                openAppSettings();
              },
              child: Text(
                'open_app_setting'.tr(),
                style: Theme.of(MyApp.appContext!).textTheme.bodySmall!
                    .copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorManager.colorPrimary,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                ctx.pop();
              },
              child: Text(
                'cancel'.tr(),
                style: Theme.of(MyApp.appContext!).textTheme.bodySmall!
                    .copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorManager.colorFontPrimary,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
