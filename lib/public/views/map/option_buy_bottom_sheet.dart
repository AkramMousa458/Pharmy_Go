import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/cubits/add_order_to_cart_cubit/add_order_to_cart_cubit.dart';
import 'package:pharmygo/patient/views/navigation_bar_transition_patient_for_home_page.dart';
import 'package:pharmygo/pharmacist/models/nearst_pharmacy_model.dart';
import 'package:pharmygo/public/cubits/quantity_counter_cubit/quantity_counter_cubit.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_circle_button.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

Future<dynamic> optionBuyBottomSheet(
    {required BuildContext context,
    required NearestPharmacyModel nearestPharmacy,
    required DrugModel drug}) {
  bool isLoading = false;
  return showModalBottomSheet(
    context: context,
    backgroundColor: ThemeColors.kSecondBackgroundColor(context),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
        child: SizedBox(
          height: 500.h,
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(right: 20.sp, left: 20.sp, bottom: 8.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nearestPharmacy.pharmacyName,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    // const Icon(deleteIcon),
                  ],
                ),
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15.0), // Adjust the radius as needed
                    child: CachedNetworkImage(
                      imageUrl: drug.imageUrl,
                      fit: BoxFit.cover,
                      height: Dimensions.screenWidth(context) / 2.6,
                      width: Dimensions.screenWidth(context) / 3,
                      placeholder: (context, url) =>
                          const Center(child: CustomLoadingIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            drug.nameEn,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: ThemeColors.kMainColor(context)),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                'Price: ',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: ThemeColors.kMainColor(context)),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                '${drug.price} LE',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: ThemeColors.kPriceColor(context),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                'Available Quantity: ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: ThemeColors.kMainColor(context),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                '${nearestPharmacy.quantity}',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: ThemeColors.kPriceColor(context),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          if (nearestPharmacy.delivery == 1)
                            Row(
                              children: [
                                Text(
                                  'Quantity: ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: ThemeColors.kMainColor(context),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CustomCircleButton(
                                      iconData: minusIcon,
                                      onPressed: () =>
                                          BlocProvider.of<QuantityCounterCubit>(
                                                  context)
                                              .decreaseQuantity(),
                                    ),
                                    BlocBuilder<QuantityCounterCubit,
                                        QuantityCounterState>(
                                      builder: (context, state) {
                                        return Text(
                                          state is QuantityCounterIncreased
                                              ? state.quantity.toString()
                                              : state is QuantityCounterDecreased
                                                  ? state.quantity.toString()
                                                  : '1',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: ThemeColors.kSecondColor(
                                                context),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                    CustomCircleButton(
                                      iconData: plusIcon,
                                      onPressed: () =>
                                          BlocProvider.of<QuantityCounterCubit>(
                                                  context)
                                              .increaseQuantity(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 70.h,
              ),
              nearestPharmacy.delivery == 1
                  ? Column(
                      children: [
                        BlocConsumer<AddOrderToCartCubit, AddOrderToCartState>(
                          listener: (context, state) {
                            if (state is AddOrderToCartFailure) {
                              isLoading = false;
                              Navigator.pop(context);
                              showSnackBar(context, state.errMessgae);
                            } else if (state is AddOrderToCartSuccsess) {
                              isLoading = false;
                              Navigator.pop(context);
                              showSnackBar(context, 'Order Added To Cart');
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                NavigationBarTransitionPatientForHomePage
                                    .routeName,
                                (route) => false,
                              );
                            } else if (state is AddOrderToCartLoading) {
                              isLoading = true;
                            }
                          },
                          builder: (context, state) {
                            return CustomButton(
                              isLoading: isLoading,
                              onPressed: () {
                                BlocProvider.of<AddOrderToCartCubit>(context)
                                    .addOrderToCart(
                                        pharmacyId: nearestPharmacy.id,
                                        drugId: drug.id,
                                        quantity: BlocProvider.of<
                                                QuantityCounterCubit>(context)
                                            .quantity);
                              },
                              text: "Add to cart",
                            );
                          },
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        CustomButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: "Start Trip",
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const Text(
                          "No Delivery Service",
                          style: TextStyle(
                            color: Color.fromARGB(234, 158, 158, 158),
                          ),
                        ),
                        // SizedBox(
                        //   height: 6.h,
                        // ),
                        // CustomButton(
                        //   onPressed: () {
                        //     Navigator.pop(context);
                        //   },
                        //   text: "Start Trip",
                        // ),
                      ],
                    ),
            ],
          ),
        ),
      );
    },
  );
}
