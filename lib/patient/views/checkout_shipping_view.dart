import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/colors.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/patient/views/checkout_order_view.dart';
import 'package:pharmygo/patient/widgets/custom_back_button.dart';
import 'package:pharmygo/patient/widgets/custom_checkbox.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';

class CheckoutShippingView extends StatefulWidget {
  const CheckoutShippingView({super.key});

  static const routeName = '/CheckoutContactView';
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<CheckoutShippingView> createState() => _CheckoutShippingViewState();
}

class _CheckoutShippingViewState extends State<CheckoutShippingView> {
  bool check = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: kMainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: const CustomBackButton(),
      ),
      backgroundColor: kSecondBackgroundColor,
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
                      //  CustomCheckbox(
                      //     lable: 'Payment', check: false, active: false),
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
              child: Form(
                key: formKey,
                child: ListView(
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
                          controller: firstName,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Your first name is missing!';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16.sp),
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
                          controller: lastName,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Your last name is missing!';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16.sp),
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
                          controller: phoneNumber,
                          isNumber: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Your phone number is missing!';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16.sp),
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
                          controller: address,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Your address is missing!';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.pushNamed(
                                  context, CheckoutOrderView.routeName,
                                  arguments: {
                                    'firstName': firstName.text,
                                    'lastName': lastName.text,
                                    'phoneNumber': phoneNumber.text,
                                    'address': address.text,
                                  });
                            }
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.arrowRight,
                            size: 38,
                          ),
                          color: kMainColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
