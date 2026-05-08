import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_medcines_cubit/get_my_medcines_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_pharmacies_cubit/get_my_pharmacies_cubit.dart';
import 'package:pharmygo/pharmacist/widgets/items_operations/custom_add_item_button.dart';
import 'package:pharmygo/pharmacist/widgets/add_drug_bottom_sheet.dart';
import 'package:pharmygo/public/cubits/fetch_drugs_cubit/fetch_drugs_cubit.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class AddButtonList extends StatefulWidget {
  const AddButtonList({super.key});

  @override
  AddButtonListState createState() => AddButtonListState();
}

class AddButtonListState extends State<AddButtonList> {
  late List<Map<String, String>> items; // Define items variable

  late List<bool> isAddedList; // Define isAddedList variable
  late List<DrugModel> myDrugs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<GetMyMedcinesCubit>(context).getMyMedcines(
          pharmacyId: BlocProvider.of<GetMyPharmaciesCubit>(context)
              .choosenPharmacy
              .id);
    });
  }

  @override
  Widget build(BuildContext context) {
    myDrugs = BlocProvider.of<GetMyMedcinesCubit>(context).myDrugs;

    return BlocBuilder<FetchDrugsCubit, FetchDrugsState>(
      builder: (context, state) {
        if (state is FetchDrugsSuccess) {
          if (myDrugs.isNotEmpty) {
            isAddedList = state.drugs
                .map((drug) => myDrugs.any((d) => d.id == drug.id))
                .toList();
          } else {
            isAddedList = List.filled(state.drugs.length, false);
          }
          return ListView.builder(
            itemCount: state.drugs.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return AddButton(
                drugModel: state.drugs[index], // Extract image from the map
                // Extract text from the map

                onPressed: () {
                  if (BlocProvider.of<GetMyPharmaciesCubit>(context)
                      .myPharmacies
                      .isEmpty) {
                    showSnackBar(context,
                        'Please add a pharmacy from your profile first!');
                  } else {
                    addDrugBottomSheet(
                        context: context,
                        title: 'Choose a pharmacy',
                        drugModel: state.drugs[index],
                        pharmacyModel:
                            BlocProvider.of<GetMyPharmaciesCubit>(context)
                                .choosenPharmacy);
                  }
                },
                isAdded: isAddedList[index],
              );
            },
          );
        } else if (state is FetchDrugsFailure) {
          showSnackBar(context, state.errMesage);
        }
        return const Center(
          child: CustomLoadingIndicator(),
        );
      },
    );
  }
}
