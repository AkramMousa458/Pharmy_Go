import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/pharmacist/cubits/delete_medicine_cubit/delete_medicine_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_medcines_cubit/get_my_medcines_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_pharmacies_cubit/get_my_pharmacies_cubit.dart';
import 'package:pharmygo/pharmacist/widgets/buttons/custom_elevated_button.dart';
import 'package:pharmygo/pharmacist/widgets/buttons/custom_outlined_button.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

Future<dynamic> deleteAlertBox(BuildContext context,
    {required DrugModel drugModel}) {
  bool isLoading = false;
  return showDialog(
    context: context,
    builder: (BuildContext cxt) {
      return Dialog(
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ThemeColors.kSecondBackgroundColor(context),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FaIcon(
                  deleteIcon,
                  color: ThemeColors.kAlarmColor(context),
                  size: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Delete Sure?',
                  style: TextStyle(
                    fontSize: 25,
                    color: ThemeColors.kAlarmColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CustomOutLinedtButton(
                      text: 'cancel',
                      action: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child:
                        BlocConsumer<DeleteMedicineCubit, DeleteMedicineState>(
                      listener: (context, state) {
                        if (state is DeleteMedicineFailure) {
                          isLoading = false;
                          showSnackBar(context, state.errMessage);
                          Navigator.pop(context);
                        } else if (state is DeleteMedicineSucssess) {
                          isLoading = false;
                          Navigator.pop(context);
                          BlocProvider.of<GetMyMedcinesCubit>(context)
                              .getMyMedcines(
                                  pharmacyId:
                                      BlocProvider.of<GetMyPharmaciesCubit>(
                                              context)
                                          .choosenPharmacy
                                          .id);
                          showSnackBar(context, 'Drug deleted sucssesfully!');
                        } else {
                          isLoading = true;
                        }
                      },
                      builder: (context, state) {
                        return isLoading
                            ? const Center(
                                child: CustomLoadingIndicator(),
                              )
                            : CustomElevatedButton(
                                text: ' Yes, delete it ',
                                action: () {
                                  BlocProvider.of<DeleteMedicineCubit>(context)
                                      .deleteMedicine(
                                          pharmacyId: BlocProvider.of<
                                                  GetMyPharmaciesCubit>(context)
                                              .choosenPharmacy
                                              .id,
                                          drugId: drugModel.id);
                                },
                              );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
