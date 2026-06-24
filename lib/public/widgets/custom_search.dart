import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/ocr_search_utils.dart';
import 'package:pharmygo/patient/widgets/custom_drug_grid_view_item.dart';
import 'package:pharmygo/patient/widgets/shimmer_home_page_patient.dart';
import 'package:pharmygo/public/cubits/fetch_drugs_cubit/fetch_drugs_cubit.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class CustomSearch extends SearchDelegate<String?> {
  CustomSearch({String? searchTerm}) {
    query = normalizeScannedDrugName(searchTerm ?? '');
  }

  @override
  String? get searchFieldLabel => 'Search drugs';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear),
        ),
      IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildDrugResults(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildDrugResults(context);

  bool _drugMatches(DrugModel drug, String term) {
    final nameEn = drug.nameEn.toLowerCase();
    final nameAr = drug.nameAr.toLowerCase();
    return nameEn.contains(term) ||
        nameAr.contains(term) ||
        term.contains(nameEn) ||
        term.contains(nameAr);
  }

  List<DrugModel> _filterDrugs(List<DrugModel> drugs) {
    final terms = drugSearchTerms(query);
    if (terms.isEmpty) return [];

    for (final term in terms) {
      final matches = drugs.where((drug) => _drugMatches(drug, term)).toList();
      if (matches.isNotEmpty) return matches;
    }

    return [];
  }

  Widget _buildDrugResults(BuildContext context) {
    if (query.trim().isEmpty) {
      return Center(
        child: Text(
          'Type or scan a drug name to search',
          style: TextStyle(color: ThemeColors.kGreyColor(context)),
        ),
      );
    }

    return BlocBuilder<FetchDrugsCubit, FetchDrugsState>(
      builder: (context, state) {
        if (state is FetchDrugsSuccess) {
          final filteredDrugs = _filterDrugs(state.drugs);

          if (filteredDrugs.isEmpty) {
            return Center(
              child: Text(
                'No drugs found for "$query"',
                textAlign: TextAlign.center,
                style: TextStyle(color: ThemeColors.kGreyColor(context)),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1 / 1.4,
              ),
              itemCount: filteredDrugs.length,
              itemBuilder: (context, index) {
                return CustomDrugGridViewItem(
                  drugModel: filteredDrugs[index],
                );
              },
            ),
          );
        } else if (state is FetchDrugsFailure) {
          return Center(child: Text(state.errMesage));
        } else if (state is FetchDrugsLoading) {
          return SizedBox(
            height: 240,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const ShimmerHomePagePatient();
                },
              ),
            ),
          );
        }

        return const CustomLoadingIndicator();
      },
    );
  }
}

void showDrugSearch(BuildContext context, {String? searchTerm}) {
  final cleaned = normalizeScannedDrugName(searchTerm ?? '');
  showSearch<String?>(
    context: context,
    query: cleaned,
    delegate: CustomSearch(searchTerm: cleaned),
  );
}
