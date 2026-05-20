// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/assets.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  int _current = 0;
  final List<String> _images = [
    Assets.slider1,
    Assets.slider2,
    Assets.slider3,
    Assets.slider4,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          items: _images.map((image) {
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ThemeColors.kMainColor(context),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _images.map((image) {
            int index = _images.indexOf(image);
            return Container(
              width: 7.0,
              height: 7.0,
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Colors.blueAccent
                    : Colors.blueGrey.withValues(alpha: .3),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 3.h),
      ],
    );
  }
}
