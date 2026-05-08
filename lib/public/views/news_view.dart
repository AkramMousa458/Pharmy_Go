import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/public/widgets/news_view_body.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});
  static String routeName = "NewsView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      appBar: PreferredSize(
        preferredSize: appBarSize,
        child: AppBar(
          title: Text(
            'News',
            style: TextStyle(
              color: ThemeColors.kMainColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          // backgroundColor: Colors.transparent,
        ),
      ),
      body: const NewsViewBody(),
    );
  }
}
