import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/patient/cubits/get_cart/get_cart_cubit.dart';
import 'package:pharmygo/patient/helper/utlis.dart';
import 'package:pharmygo/patient/views/checkout_shipping_view.dart';
import 'package:pharmygo/patient/widgets/custom_cart_list_widget.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';

class MyCartView extends StatefulWidget {
  const MyCartView({super.key});

  static const String routeName = '/MyCartView';

  @override
  State<MyCartView> createState() => _MyCartViewState();
}

class _MyCartViewState extends State<MyCartView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<GetCartCubit>(context).getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(
            color: ThemeColors.kMainColor(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: ThemeColors.kBackgroundColor(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: CustomCartListWidget(),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: ThemeColors.kAppBarColor(context),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Total Amount: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeColors.kMainColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<GetCartCubit, GetCartState>(
                      builder: (context, state) {
                        return Text(
                          state is GetCartSuccsess
                              ? '${totalCost(orders: state.ordersList)} LE'
                              : state is GetCartLoading
                                  ? 'Counting...'
                                  : '0.0',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: ThemeColors.kSecondColor(context),
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomButton(
                    text: 'Confirm Order',
                    onPressed: () {
                      if (BlocProvider.of<GetCartCubit>(context)
                          .ordersList
                          .isEmpty) {
                        showSnackBar(context, 'No items in cart!');
                      } else {
                        Navigator.pushNamed(
                            context, CheckoutShippingView.routeName);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 65.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
