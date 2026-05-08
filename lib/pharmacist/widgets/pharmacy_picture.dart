import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';

class PharmacyPicture extends StatelessWidget {
  const PharmacyPicture({
    super.key,
    required this.picture,
  });
  final String picture;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: GestureDetector(
          onTap: () {
            showImageViewer(context, Image.asset(picture).image,
                swipeDismissible: false);
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0B3490),
              image: DecorationImage(
                image: AssetImage(picture),
                fit: BoxFit.cover,
              ),
            ),
            height: 230,
            width: double.infinity,
          ),
        ));
  }
}
