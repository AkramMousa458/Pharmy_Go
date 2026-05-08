import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/views/navigation_bar_transition_patient_for_home_page.dart';
import 'package:pharmygo/patient/widgets/custom_checkbox.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class OrderFinishedView extends StatefulWidget {
  const OrderFinishedView({super.key});

  static const routeName = '/OrderFinishedView';
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<OrderFinishedView> createState() => _CheckoutShippingViewState();
}

class _CheckoutShippingViewState extends State<OrderFinishedView> {
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
        // leading: const CustomBackButton(),
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
                          lable: 'Shipping', check: true, active: true),
                      SizedBox(width: Dimensions.screenWidth(context) / 8),
                      // const CustomCheckbox(
                      //     lable: 'Payment', check: true, active: true),
                      SizedBox(width: Dimensions.screenWidth(context) / 8),
                      const CustomCheckbox(
                          lable: '  Order  ', check: true, active: true),
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
                  const Spacer(flex: 1),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: FaIcon(
                          circleCheck,
                          size: 60,
                          color: ThemeColors.kMainColor(context),
                        ),
                      ),
                      Text(
                        'Your Order Has been Submited',
                        style: TextStyle(
                          color: ThemeColors.kMainColor(context),
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 1),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: 'Done',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        NavigationBarTransitionPatientForHomePage.routeName,
                        (route) => false,
                      );
                    },
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
