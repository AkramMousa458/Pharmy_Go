import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:pharmygo/core/utils/assets.dart';
import 'package:pharmygo/core/utils/dimensions.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.picture,
    this.file,
    this.radius,
  });
  final String picture;
  final File? file;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    const String baseUrlForImage = "https://spider.yamalalsham.shop/";
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () {
            showImageViewer(
                context,
                picture.isEmpty && file == null
                    ? const AssetImage(Assets.profile)
                    : file != null
                        ? FileImage(file!) as ImageProvider
                        : NetworkImage(baseUrlForImage + picture.substring(0)),
                swipeDismissible: false);
          },
          child: CircleAvatar(
            radius: radius ?? Dimensions.screenWidth(context) / 4.8,
            backgroundImage: picture.isEmpty && file == null
                ? const AssetImage(Assets.profile)
                : file != null
                    ? FileImage(file!) as ImageProvider
                    : NetworkImage(baseUrlForImage + picture),
          ),
        ));
  }
}
