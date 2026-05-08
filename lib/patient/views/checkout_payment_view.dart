import 'package:flutter/material.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/widgets/custom_back_button.dart';
import 'package:pharmygo/patient/widgets/custom_checkbox.dart';
import 'package:pharmygo/patient/widgets/home_pay_details_widget.dart';
import 'package:pharmygo/patient/widgets/payment_method_card.dart';
import 'package:pharmygo/patient/widgets/visa_payment_details_widget.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CheckoutPaymentView extends StatefulWidget {
  const CheckoutPaymentView({super.key});

  static const routeName = '/CheckoutPaymentView';
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<CheckoutPaymentView> createState() => _CheckoutPaymentViewState();
}

class _CheckoutPaymentViewState extends State<CheckoutPaymentView> {
  bool check = false;
  bool visaPay = true, homePay = false;
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
                          lable: 'Shipping', check: true, active: true),
                      SizedBox(width: Dimensions.screenWidth(context) / 8),
                      const CustomCheckbox(
                          lable: 'Payment', check: false, active: true),
                      SizedBox(width: Dimensions.screenWidth(context) / 8),
                      const CustomCheckbox(
                          lable: '  Order  ', check: false, active: false),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 16,
                    color: ThemeColors.kSecondColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    PaymentMethodCard(
                      iconData: visaIcon,
                      isSelected: visaPay,
                      onTap: () {
                        visaPay = true;
                        homePay = false;
                        setState(() {});
                      },
                    ),
                    PaymentMethodCard(
                      iconData: handMoney,
                      isSelected: homePay,
                      onTap: () {
                        visaPay = false;
                        homePay = true;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
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
              child: visaPay
                  ? const VisaPayDetailsWidget()
                  : const HomePayDetailsWidget(),
            ),
          )
        ],
      ),
    );
  }
}
