import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/pharmacist/cubits/add_medcine/add_medcine_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_medcines_cubit/get_my_medcines_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_pharmacies_cubit/get_my_pharmacies_cubit.dart';
import 'package:pharmygo/public/cubits/fetch_drugs_cubit/fetch_drugs_cubit.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

Future<dynamic> editQuantityDrugBottomSheet(
    {required BuildContext context,
    required String title,
    // required PharmacyModel pharmacyModel,
    required DrugModel drugModel}) {
  final TextEditingController quantityController = TextEditingController();
  bool isLoading = false;
  // final List<PharmacyModel> pharmacies =
  //     BlocProvider.of<GetMyPharmaciesCubit>(context).myPharmacies;

  // List<String> myPharmacis = pharmacies.map<String>((PharmacyModel pharmacy) {
  //   return pharmacy.pharmacyName;
  // }).toList();
  // String dropdownValue = myPharmacis[0];
  return showModalBottomSheet(
    context: context,
    backgroundColor: ThemeColors.kSecondBackgroundColor(context),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 40,
          right: 40,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: 250.h,
          child: ListView(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("My Pharmacis",style: TextStyle(color: ThemeColors.kMainColor(context)),),
              //     SizedBox(
              //       width: 200,
              //       child: DropdownButtonFormField<String>(
              //         value: dropdownValue,
              //         isExpanded: true,
              //         icon: const Icon(Icons.arrow_drop_down_rounded),
              //         iconSize: 24.sp,
              //         elevation: 16,
              //         style: const TextStyle(color: kMainColor),
              //         decoration: InputDecoration(
              //           enabledBorder: OutlineInputBorder(
              //             borderSide: const BorderSide(
              //                 color: Colors.blueAccent, width: 2.0),
              //             borderRadius: BorderRadius.circular(12.0),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderSide: const BorderSide(
              //                 color: Colors.blueAccent, width: 2.0),
              //             borderRadius: BorderRadius.circular(12.0),
              //           ),
              //           filled: true,
              //           fillColor: Colors.blue.withOpacity(0.1),
              //           contentPadding: const EdgeInsets.symmetric(
              //               vertical: 12.0, horizontal: 16.0),
              //         ),
              //         onChanged: (String? newValue) {
              //           dropdownValue = newValue!;
              //         },
              //         items: myPharmacis
              //             .map<DropdownMenuItem<String>>((String pharmacy) {
              //           return DropdownMenuItem<String>(
              //             value: pharmacy,
              //             child: Text(pharmacy),
              //           );
              //         }).toList(),
              //         selectedItemBuilder: (BuildContext context) {
              //           return myPharmacis.map<Widget>((String pharmacy) {
              //             return Center(child: Text(pharmacy));
              //           }).toList();
              //         },
              //         menuMaxHeight: 200,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 20,
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Quantity"),
                  CustomTextField(
                    isNumber: true,
                    width: 200,
                    inputColor: Colors.black,
                    controller: quantityController,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<AddMedcineCubit, AddMedcineState>(
                listener: (context, state) {
                  if (state is AddMedcineFailure) {
                    isLoading = false;
                    Navigator.pop(context);
                    showSnackBar(context, state.errMessage);
                  } else if (state is AddMedcineSuccess) {
                    isLoading = false;
                    BlocProvider.of<GetMyMedcinesCubit>(context).getMyMedcines(
                        pharmacyId:
                            BlocProvider.of<GetMyPharmaciesCubit>(context)
                                .choosenPharmacy
                                .id);
                    Navigator.pop(context);
                    showSnackBar(context, 'Medicine Added Successfully!');
                  } else {
                    isLoading = true;
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    onPressed: () {
                      // BlocProvider.of<AddMedcineCubit>(context).addMedcine(
                      //   pharmacyId: pharmacyModel.id,
                      //   drugId: drugModel.id,
                      //   quantity: int.parse(quantityController.text),
                      // );
                      BlocProvider.of<FetchDrugsCubit>(context).fetchDrugs();
                      showSnackBar(context, "Quantity Edited Seccessfully");
                      Navigator.pop(context);
                    },
                    text: "Edit",
                    isLoading: isLoading,
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
