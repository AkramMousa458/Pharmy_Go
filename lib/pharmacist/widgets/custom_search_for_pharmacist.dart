import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_medcines_cubit/get_my_medcines_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_pharmacies_cubit/get_my_pharmacies_cubit.dart';
import 'package:pharmygo/pharmacist/widgets/add_drug_bottom_sheet.dart';
import 'package:pharmygo/pharmacist/widgets/items_operations/custom_add_item_button.dart';
import 'package:pharmygo/public/cubits/fetch_drugs_cubit/fetch_drugs_cubit.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class CustomSearchForPharmacist extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    late List<bool> isAddedList;
    late List<DrugModel> myDrugs;

    myDrugs = BlocProvider.of<GetMyMedcinesCubit>(context).myDrugs;

    return query.isNotEmpty
        ? Column(
          children: [
              Expanded(
                child: BlocBuilder<FetchDrugsCubit, FetchDrugsState>(
                  builder: (context, state) {
                    if (state is FetchDrugsSuccess) {
                      final List<DrugModel> filteredDrugs = state.drugs
                          .where((drug) => drug.nameEn
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                      if (myDrugs.isNotEmpty) {
                        isAddedList = filteredDrugs
                            .map((drug) => myDrugs.any((d) => d.id == drug.id))
                            .toList();
                      } else {
                        isAddedList = List.filled(filteredDrugs.length, false);
                      }
                      return ListView.builder(
                        itemCount: filteredDrugs.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AddButton(
                            drugModel: filteredDrugs[index],
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
                                    drugModel: filteredDrugs[index],
                                    pharmacyModel:
                                        BlocProvider.of<GetMyPharmaciesCubit>(
                                                context)
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
                ),
              ),
            ],
          )
        : Center(
            child: Text(
              "Search For Medcine",
              style: TextStyle(color: ThemeColors.kMainColor(context)),
            ),
          );
  }
}
