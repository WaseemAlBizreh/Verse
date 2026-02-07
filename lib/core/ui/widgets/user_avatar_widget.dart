import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../resources/asset_manger.dart';
import '../resources/color_manager.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({
    super.key,
    required this.image,
    required this.radius,
    this.isFile = false,
  });

  final String? image;
  final double radius;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object>? backgroundImage;

    if (image == null || image!.isEmpty) {
      backgroundImage =
          AssetImage(ImageAssets.userImage) as ImageProvider<Object>;
    } else if (isFile) {
      backgroundImage = FileImage(File(image!)) as ImageProvider<Object>;
    } else {
      backgroundImage =
          CachedNetworkImageProvider(image!) as ImageProvider<Object>;
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: ColorManager.colorBackground,
      backgroundImage: backgroundImage,
      onBackgroundImageError: (exception, stackTrace) {
        // Handle image loading errors gracefully
      },
    );
  }
}
