import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/api_services.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/patient/cubits/add_order_cubit/add_drug_cart_cubit.dart';
import 'package:pharmygo/patient/cubits/delete_order_from_cart_cubit/delete_order_from_cart_cubit.dart';
import 'package:pharmygo/patient/cubits/get_cart/get_cart_cubit.dart';
import 'package:pharmygo/patient/helper/utlis.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo_impl.dart';
import 'package:pharmygo/patient/views/order_finished_view.dart';
import 'package:pharmygo/patient/widgets/custom_back_button.dart';
import 'package:pharmygo/patient/widgets/custom_checkbox.dart';
import 'package:pharmygo/patient/widgets/custom_order_card.dart';
import 'package:pharmygo/patient/widgets/custom_order_photo_card.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CheckoutOrderView extends StatefulWidget {
  const CheckoutOrderView({super.key});

  static const routeName = '/CheckoutOrderView';
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<CheckoutOrderView> createState() => _CheckoutShippingViewState();
}

class _CheckoutShippingViewState extends State<CheckoutOrderView> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    bool isLoading = false;
    return BlocProvider(
      create: (context) =>
          DeleteOrderFromCartCubit(PatientsRepoImpl(ApiService(Dio()))),
      child: Scaffold(
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
        body: Column(
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
                            lable: '  Order  ', check: false, active: true),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(left: 25, right: 25, bottom: 50),
                width: Dimensions.screenWidth(context),
                decoration: BoxDecoration(
                  color: ThemeColors.kTextColor(context),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomOrderInfoCard(
                        title: 'Shipping to :',
                        body: args['address'],
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      // CustomOrderInfoCard(
                      //   title: 'Payment Details',
                      //   body: '****  ****  ****  1234',
                      //   onPressed: () {},
                      // ),
                      CustomOrderProducsCard(
                        title: 'Your Order',
                        ordersList:
                            BlocProvider.of<GetCartCubit>(context).ordersList,
                        onPressed: () {},
                      ),
                      CustomOrderInfoCard(
                        title: 'Delivery',
                        body: 'Total Cost :',
                        isStaticValue: true,
                        totalPrice:
                            '${totalCost(orders: BlocProvider.of<GetCartCubit>(context).ordersList)} LE',
                        onPressed: () {},
                      ),
                      const SizedBox(height: 30),
                      BlocConsumer<AddOrderCubit, AddOrderState>(
                        listener: (context, state) {
                          if (state is AddOrderFailure) {
                            isLoading = false;
                            showSnackBar(context, state.errMessgae);
                          } else if (state is AddOrderSuccsess) {
                            isLoading = false;
                            for (var order
                                in BlocProvider.of<GetCartCubit>(context)
                                    .ordersList) {
                              BlocProvider.of<DeleteOrderFromCartCubit>(context)
                                  .deleteOrderFromCart(orderId: order.id);
                            }
                            Navigator.pushNamed(
                                context, OrderFinishedView.routeName);
                          } else {
                            isLoading = true;
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            text: 'Submit',
                            isLoading: isLoading,
                            onPressed: () {
                              for (var order
                                  in BlocProvider.of<GetCartCubit>(context)
                                      .ordersList) {
                                BlocProvider.of<AddOrderCubit>(context)
                                    .addOrder(
                                        pharmacyId: order.pharmacy.id,
                                        drugId: order.items[0].drug.id,
                                        quantity: order.items[0].quantity);
                              }
                              // Navigator.pushNamed(
                              //     context, OrderFinishedView.routeName);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
