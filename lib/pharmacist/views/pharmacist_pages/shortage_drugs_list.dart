import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/pharmacist/cubits/get_shortage_drug_cubit/get_shortage_drug_cubit.dart';
import 'package:pharmygo/pharmacist/widgets/shortage_drug_item.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class ShortageDrugsList extends StatelessWidget {
  const ShortageDrugsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<GetShortageDrugCubit, GetShortageDrugState>(
        builder: (context, state) {
          if (state is GetShortageDrugFailure) {
            log('--------------${state.errMessage}-----------------');
            // showSnackBar(context, state.errMessage);
            return const SizedBox();
          } else if (state is GetShortageDrugSuccsess) {
            if (state.shortageDrugs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      drugsIcon,
                      size: 80.sp,
                      color: ThemeColors.kMainColor(context),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Every thing is OK',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('No Shortage in your drugs'),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.shortageDrugs.length,
                itemBuilder: (context, index) {
                  return ShortageDrugItem(
                    shortageDrugModel: state.shortageDrugs[index],
                  );
                },
              );
            }
          } else {
            return const Center(
              child: CustomLoadingIndicator(),
            );
          }
        },
      ),
    );
  }
}
