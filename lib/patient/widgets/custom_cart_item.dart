import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/api_services.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/cubits/delete_order_from_cart_cubit/delete_order_from_cart_cubit.dart';
import 'package:pharmygo/patient/cubits/get_cart/get_cart_cubit.dart';
import 'package:pharmygo/patient/repos/patients_repo/patients_repo_impl.dart';
import 'package:pharmygo/public/models/order_model.dart';
import 'package:pharmygo/public/widgets/custom_circle_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class CustomCartItem extends StatelessWidget {
  const CustomCartItem({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    bool isDeleteLoading = false;
    return BlocProvider(
      create: (context) =>
          DeleteOrderFromCartCubit(PatientsRepoImpl(ApiService(Dio()))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        height: 115.h,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ThemeColors.kSecondBackgroundColor(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showImageViewer(
                    context, NetworkImage(orderModel.items[0].drug.imageUrl),
                    // context, NetworkImage(orderModel.items[0].drug.imageUrl),
                    swipeDismissible: false);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  imageUrl: orderModel.items[0].drug.imageUrl,
                  fit: BoxFit.cover,
                  height: Dimensions.screenWidth(context) / 2.6,
                  width: Dimensions.screenWidth(context) / 4,
                  placeholder: (context, url) =>
                      const Center(child: CustomLoadingIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
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
                      orderModel.items[0].drug.nameEn,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: ThemeColors.kSecondColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Quantity:  ',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ThemeColors.kGreyColor(context),
                          ),
                        ),
                        Text(
                          orderModel.items[0].quantity.toString(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: ThemeColors.kSecondColor(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      orderModel.pharmacy.pharmacyName,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: ThemeColors.kGreyColor(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocConsumer<DeleteOrderFromCartCubit,
                    DeleteOrderFromCartState>(
                  listener: (context, state) {
                    if (state is DeleteOrderFromCartFailure) {
                      isDeleteLoading = false;
                      showSnackBar(context, state.errMessage);
                    } else if (state is DeleteOrderFromCartSuccsess) {
                      isDeleteLoading = false;
                      BlocProvider.of<GetCartCubit>(context).getCart();
                      showSnackBar(context, state.message);
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
                              BlocProvider.of<DeleteOrderFromCartCubit>(context)
                                  .deleteOrderFromCart(orderId: orderModel.id);
                            },
                          );
                  },
                ),
                Text(
                  '${orderModel.totalAmount} LE',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: ThemeColors.kPriceColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
