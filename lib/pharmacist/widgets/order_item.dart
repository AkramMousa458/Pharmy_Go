import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/api_services.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/cubits/delete_order_from_cart_cubit/delete_order_from_cart_cubit.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo_impl.dart';
import 'package:pharmygo/pharmacist/cubits/delete_order_cubit/delete_order_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_pharmacies_cubit/get_my_pharmacies_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_pharmacy_orders/get_pharmacy_orders_cubit.dart';
import 'package:pharmygo/pharmacist/models/pharmacy_orders_model.dart';
import 'package:pharmygo/pharmacist/widgets/pharmacy_drug_order_item.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_circle_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.pharmacyOrderModel,
  });

  final PharmacyOrderModel pharmacyOrderModel;

  @override
  Widget build(BuildContext context) {
    log(' imageUrl ${pharmacyOrderModel.patient.imageUrl}');
    log('phone  ${pharmacyOrderModel.patient.phone}');
    log('address ${pharmacyOrderModel.patient.address}');
    bool isDeleteLoading = false;
    return BlocProvider(
      create: (context) =>
          DeleteOrderFromCartCubit(PatientsRepoImpl(ApiService(Dio()))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ThemeColors.kSecondBackgroundColor(context),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                    // 'https://spider.yamalalsham.shop/${pharmacyOrderModel.patient.imageUrl}',
                    fit: BoxFit.cover,
                    height: 50.h,
                    width: 50.w,
                    placeholder: (context, url) =>
                        const Center(child: CustomLoadingIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pharmacyOrderModel.patient.name,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ThemeColors.kSecondColor(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              pharmacyOrderModel.patient.phone,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: ThemeColors.kGreyColor(context),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            FaIcon(
                              locationIcon,
                              size: 12.sp,
                              color: ThemeColors.kMainColor(context),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Text(
                                pharmacyOrderModel.patient.address.isNotEmpty
                                    ? pharmacyOrderModel.patient.address
                                    : 'Egypt, Shepin',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: ThemeColors.kGreyColor(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocConsumer<DeleteOrderCubit, DeleteOrderState>(
                      listener: (context, state) {
                        if (state is DeleteOrderFailure) {
                          isDeleteLoading = false;
                          showSnackBar(context, state.errMessage);
                        } else if (state is DeleteOrderSucssess) {
                          isDeleteLoading = false;
                          BlocProvider.of<GetPharmacyOrdersCubit>(context)
                              .getPharmacyOrders(
                                  pharmacyId:
                                      BlocProvider.of<GetMyPharmaciesCubit>(
                                              context)
                                          .choosenPharmacy
                                          .id);
                        } else {
                          isDeleteLoading = true;
                        }
                      },
                      builder: (context, state) {
                        return isDeleteLoading
                            ? const CustomLoadingIndicator()
                            : CustomCircleButton(
                                iconData: deleteIcon,
                                backgroundColor: Colors.transparent,
                                iconColor: ThemeColors.kThirdTextColor(context),
                                iconSize: 22,
                                onPressed: () {
                                  for (var element
                                      in pharmacyOrderModel.orders) {
                                    BlocProvider.of<DeleteOrderCubit>(context)
                                        .deleteOrder(
                                            patientId:
                                                pharmacyOrderModel.patient.id,
                                            orderId: element.id);
                                  }
                                  // BlocProvider.of<DeleteOrderCubit>(context)
                                  //     .deleteMedicine(patientId:  pharmacyOrderModel.patient.id, orderId: pharmacyOrderModel.orders[index]);
                                },
                              );
                      },
                    ),
                    Text(
                      '${pharmacyOrderModel.orders[0].totalAmount} LE',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: ThemeColors.kPriceColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pharmacyOrderModel.orders.length,
              itemBuilder: (context, index) {
                return PharmacyDrugOrderItem(
                  customOrderModel: pharmacyOrderModel.orders[index],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                onPressed: () {
                  for (var element in pharmacyOrderModel.orders) {
                    BlocProvider.of<DeleteOrderCubit>(context).deleteOrder(
                        patientId: pharmacyOrderModel.patient.id,
                        orderId: element.id);
                  }
                },
                text: 'Confirm Order',
                textSize: 14.sp,
                width: 255.w,
                height: 40.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
