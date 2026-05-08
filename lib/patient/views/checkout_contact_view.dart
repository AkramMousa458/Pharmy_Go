import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/patient/views/checkout_payment_view.dart';
import 'package:pharmygo/patient/widgets/custom_back_button.dart';
import 'package:pharmygo/patient/widgets/custom_checkbox.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CheckoutContactView extends StatefulWidget {
  const CheckoutContactView({super.key});

  static const routeName = '/CheckoutContactView';
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<CheckoutContactView> createState() => _CheckoutShippingViewState();
}

class _CheckoutShippingViewState extends State<CheckoutContactView> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
            color: ThemeColors.kMainColor(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: const CustomBackButton(),
      ),
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 30,
                    right: 33,
                    left: 35,
                    child: Container(
                      color: Colors.white,
                      height: 4,
                      width: Dimensions.screenWidth(context) / 2,
                    ),
                  ),
                  Row(
                    children: [
                      const CustomCheckbox(
                          lable: 'Shipping', check: false, active: true),
                      SizedBox(width: Dimensions.screenWidth(context) / 8),
                      const CustomCheckbox(
                          lable: 'Payment', check: false, active: false),
                      SizedBox(width: Dimensions.screenWidth(context) / 8),
                      const CustomCheckbox(
                          lable: '  Order  ', check: false, active: false),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 50),
            child: Container(
              padding: const EdgeInsets.all(20),
              width: Dimensions.screenWidth(context),
              height: 500,
              decoration: BoxDecoration(
                color: ThemeColors.kTextColor(context),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Name',
                        style: TextStyle(
                          fontSize: 18,
                          color: ThemeColors.kSecondColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(
                        onChange: (value) {},
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Name',
                        style: TextStyle(
                          fontSize: 18,
                          color: ThemeColors.kSecondColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(
                        onChange: (value) {},
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: 18,
                          color: ThemeColors.kSecondColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(
                        onChange: (value) {},
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 18,
                          color: ThemeColors.kSecondColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(
                        onChange: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, CheckoutPaymentView.routeName);
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.arrowRight,
                          size: 38,
                        ),
                        color: ThemeColors.kMainColor(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
