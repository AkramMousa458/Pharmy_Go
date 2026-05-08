import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/patient/widgets/custom_edit_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CustomOrderInfoCard extends StatelessWidget {
  const CustomOrderInfoCard({
    super.key,
    required this.title,
    required this.body,
    required this.onPressed,
    this.isStaticValue = false,
    this.totalPrice = '',
  });

  final String title, body, totalPrice;
  final VoidCallback onPressed;
  final bool isStaticValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: ThemeColors.kLightGreyColor(context),
        border: Border.all(color: ThemeColors.kGreyColor(context)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: ThemeColors.kMainColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isStaticValue != true)
                CustomEditButton(text: 'Edit', onPressed: onPressed),
            ],
          ),
          isStaticValue == false
              ? Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: Text(
                    body,
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeColors.kThirdTextColor(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        body,
                        style: TextStyle(
                          fontSize: 16,
                          color: ThemeColors.kThirdTextColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.screenWidth(context) / 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4, bottom: 4, left: 10),
                          child: Text(
                            totalPrice,
                            style: TextStyle(
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              color: ThemeColors.kSecondColor(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
