import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/patient/widgets/custom_drug_grid_view_item.dart';
import 'package:pharmygo/patient/widgets/shimmer_home_page_patient.dart';
import 'package:pharmygo/public/cubits/fetch_drugs_cubit/fetch_drugs_cubit.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class CustomSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            close(context, null);
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<FetchDrugsCubit, FetchDrugsState>(
      builder: (context, state) {
        if (state is FetchDrugsSuccess) {
          final List<DrugModel> filteredDrugs = state.drugs
              .where((drug) =>
                  drug.nameEn.toLowerCase().contains(query.toLowerCase()))
              .toList();

          return Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 16, // Spacing between columns
                mainAxisSpacing: 16, // Spacing between rows
                childAspectRatio: 1 / 1.4,
              ),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: filteredDrugs.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomDrugGridViewItem(
                  drugModel: filteredDrugs[index],
                );
              },
            ),
          );
        } else if (state is FetchDrugsFailure) {
          return Text(state.errMesage);
        } else if (state is FetchDrugsLoading) {
          return SizedBox(
            height: 240,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return const ShimmerHomePagePatient();
                },
              ),
            ),
          );
        } else {
          return const CustomLoadingIndicator();
        }
      },
    );
  }
}
