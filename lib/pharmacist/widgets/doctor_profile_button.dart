import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/colors.dart';

class DoctorProfileBtn extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor, textColor;
  final double width, height, borderRadius, textSize;
  final FaIconData? icon;

  const DoctorProfileBtn({super.key,
    this.onPressed,
    required this.text,
    this.backgroundColor = kMainButtonColor,
    this.borderRadius = 32,
    this.textSize = 20,
    this.height = 50,
    this.width = 300,
    this.textColor = kTextColor,
    this.icon,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height, 
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 5)),
        ],
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 15),
            child: FaIcon(icon,color: Colors.white,weight: 25,),
          ),
          MaterialButton(
            // style: ElevatedButton.styleFrom(
            //     shape: const StadiumBorder(), backgroundColor: backgroundColor),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(fontSize: textSize, color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}