// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pharmygo/core/helper/show_snack_bar.dart';
// import 'package:pharmygo/core/utils/dimensions.dart';
// import 'package:pharmygo/patient/cubits/get_nearst_pharmacies_with_drug_cubit/get_nearst_pharmacies_with_drug_cubit.dart';
// import 'package:pharmygo/pharmacist/widgets/pharmacy_item_widget.dart';
// import 'package:pharmygo/public/models/drug_model.dart';
// import 'package:pharmygo/public/widgets/custom_button.dart';
// import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';
// import 'package:pharmygo/core/theme/theme_colors.dart';

// class CustomDrugsOrderListWidget extends StatelessWidget {
//   const CustomDrugsOrderListWidget({super.key, required this.productModel});

//   final DrugModel productModel;

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       physics: const BouncingScrollPhysics(),
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//           height: Dimensions.screenHeight(context) / 3,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: Colors.white,
//             image: DecorationImage(
//               fit: BoxFit.cover,
//               image: CachedNetworkImageProvider(
//                 productModel.imageUrl,
//                 errorListener: (p0) => const Icon(Icons.error),
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     productModel.nameEn,
//                     style: TextStyle(
//                       color: ThemeColors.kSecondColor(context),
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         'Price : ',
//                         style: TextStyle(
//                           color: ThemeColors.kMainColor(context),
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         '${productModel.price} LE',
//                         style:  TextStyle(
//                           color: ThemeColors.kPriceColor(context),
//                           fontSize: 30,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     productModel.nameAr,
//                     style: TextStyle(
//                       color: ThemeColors.kSecondColor(context),
//                       fontSize: 16,
//                       height: 1,
//                     ),
//                     maxLines: 5,
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.start,
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//                   const SizedBox(height: 25),
//                   CustomButton(
//                     text: 'Find Nearst Pharmacy',
//                     onPressed: () {
//                       BlocProvider.of<GetNearstPharmciesWithDrugCubit>(context)
//                           .getNearstPharmaciesWithDrug(drugId: productModel.id);
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//           child: BlocBuilder<GetNearstPharmciesWithDrugCubit,
//               GetNearstPharmciesWithDrugState>(
//             builder: (context, state) {
//               if (state is GetNearstPharmciesWithDrugFailure) {
//                 showSnackBar(context, state.errMessage);
//                 return const SizedBox();
//               } else if (state is GetNearstPharmciesWithDrugSuccsess) {
//                 return state.nearstPharmacies.isEmpty
//                     ? Center(
//                         child: Text(
//                           'Sorry! The drug not found near to you',
//                           style:
//                               TextStyle(color: ThemeColors.kGreyColor(context)),
//                         ),
//                       )
//                     : Expanded(
//                         child: ListView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: state.nearstPharmacies.length,
//                           itemBuilder: (context, index) {
//                             return PharmacyItemWidget(
//                               nearestPharmacyModel:
//                                   state.nearstPharmacies[index],
//                               drugModel: productModel,
//                             );
//                           },
//                         ),
//                       );
//               } else if (state is GetNearstPharmciesWithDrugLoading) {
//                 return const Center(child: CustomLoadingIndicator());
//               } else {
//                 return const SizedBox();
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/patient/cubits/get_nearst_pharmacies_with_drug_cubit/get_nearst_pharmacies_with_drug_cubit.dart';
import 'package:pharmygo/pharmacist/widgets/pharmacy_item_widget.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class CustomDrugsOrderListWidget extends StatelessWidget {
  const CustomDrugsOrderListWidget({super.key, required this.productModel});

  final DrugModel productModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          height: Dimensions.screenHeight(context) / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                productModel.imageUrl,
                errorListener: (p0) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.nameEn,
                    style: TextStyle(
                      color: ThemeColors.kSecondColor(context),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Price : ',
                        style: TextStyle(
                          color: ThemeColors.kMainColor(context),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${productModel.price} LE',
                        style: TextStyle(
                          color: ThemeColors.kPriceColor(context),
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    productModel.nameAr,
                    style: TextStyle(
                      color: ThemeColors.kSecondColor(context),
                      fontSize: 16,
                      height: 1,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 25),
                  CustomButton(
                    text: 'Find Nearst Pharmacy',
                    onPressed: () {
                      BlocProvider.of<GetNearstPharmciesWithDrugCubit>(context)
                          .getNearstPharmaciesWithDrug(drugId: productModel.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: BlocBuilder<GetNearstPharmciesWithDrugCubit,
              GetNearstPharmciesWithDrugState>(
            builder: (context, state) {
              if (state is GetNearstPharmciesWithDrugFailure) {
                showSnackBar(context, state.errMessage);
                return const SizedBox();
              } else if (state is GetNearstPharmciesWithDrugSuccsess) {
                log("success state.nearstPharmacies ${state.nearstPharmacies}");
                return state.nearstPharmacies.isEmpty
                    ? Center(
                        child: Text(
                          'Sorry! The drug not found near to you',
                          style:
                              TextStyle(color: ThemeColors.kGreyColor(context)),
                        ),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.nearstPharmacies.length,
                        itemBuilder: (context, index) {
                          return PharmacyItemWidget(
                            nearestPharmacyModel: state.nearstPharmacies[index],
                            drugModel: productModel,
                          );
                        },
                      );
              } else if (state is GetNearstPharmciesWithDrugLoading) {
                return const Center(child: CustomLoadingIndicator());
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
