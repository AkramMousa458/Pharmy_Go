import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/assets.dart';
import '../../../public/widgets/custom_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CustomDone extends StatelessWidget {
  final String text;
  final bool isText;
  const CustomDone({
    super.key,
    this.text = '',
    this.isText = false, // Fixed the key parameter
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 175, bottom: 50),
              child: Image.asset(
                Assets.done,
                fit: BoxFit.contain,
                height: 219,
                width: 219,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    isText
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Text(
                              "Your request for registration has been sent",
                              style: TextStyle(
                                fontSize: 25,
                                color: ThemeColors.kSecondColor(context),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const Text(""),
                    CustomButton(
                      // width: 360,
                      isBold: true,
                      height: 60,
                      backgroundColor: ThemeColors.kSecondColor(context),
                      textColor: ThemeColors.kSecondButtonColor(context),
                      text: 'Done',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
