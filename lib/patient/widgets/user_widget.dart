import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/public/models/auth_model.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key, required this.user, required this.userName});

  final AuthModel user;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Container(
          //   width: 60,
          //   height: 60,
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: NetworkImage(user.),
          //       ),
          //       borderRadius: BorderRadius.circular(150)),
          // ),
          FaIcon(pharmacyIcon, color: ThemeColors.kMainColor(context)),
          const SizedBox(width: 20),
          Text(
            userName == user.name ? '${user.name} (Me)' : user.name,
            style:
                const TextStyle(color: Colors.black, fontSize: 25, height: 1),
          ),
        ],
      ),
    );
  }
}
