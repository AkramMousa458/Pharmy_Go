import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      this.title,
      this.endIcon,
      this.endIconAction,
      required this.scaffoldKey});
  final double iconSize = 25;
  final String? title;
  final FaIconData? endIcon;
  final VoidCallback? endIconAction;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? '',
        style: TextStyle(color: ThemeColors.kMainColor(context)),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: endIcon != null ? FaIcon(endIcon) : const FaIcon(null),
            color: ThemeColors.kSecondColor(context),
            onPressed: endIcon != null ? endIconAction : null,
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: ThemeColors.kSecondColor(context),
          size: 30,
        ),
        onPressed: () {
          if (scaffoldKey.currentState!.isDrawerOpen) {
            scaffoldKey.currentState!.closeDrawer();
            //close drawer, if drawer is open
          } else {
            scaffoldKey.currentState!.openDrawer();
            //open drawer, if drawer is closed
          }
        },
      ),
    );
  }
}
