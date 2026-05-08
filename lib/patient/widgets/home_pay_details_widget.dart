import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/patient/views/checkout_order_view.dart';

class HomePayDetailsWidget extends StatelessWidget {
   const HomePayDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Expanded(
          child: Center(
            child: Text(
              'Cash On Delivery',
              style: TextStyle(
                fontSize: 18,
                color: ThemeColors.kSecondColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CheckoutOrderView.routeName);
              },
              icon:  const FaIcon(
                FontAwesomeIcons.arrowRight,
                size: 38,
              ),
              color: ThemeColors.kMainColor(context),
            ),
          ],
        ),
      ],
    );
  }
}
