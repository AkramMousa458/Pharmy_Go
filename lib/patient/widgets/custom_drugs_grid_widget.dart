import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/public/cubits/fetch_drugs_cubit/fetch_drugs_cubit.dart';
import 'package:pharmygo/patient/widgets/custom_drug_grid_view_item.dart';

class CustomDrugsGridView extends StatelessWidget {
  const CustomDrugsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FetchDrugsCubit fetchDrugsCubit = BlocProvider.of<FetchDrugsCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 16),
      child: BlocBuilder<FetchDrugsCubit, FetchDrugsState>(
        builder: (context, state) {
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 16, // Spacing between columns
              mainAxisSpacing: 16, // Spacing between rows
              childAspectRatio: 1 / 1.4,
            ),
            itemCount: fetchDrugsCubit.drugsList.length,
            itemBuilder: (context, index) {
              return CustomDrugGridViewItem(
                drugModel: fetchDrugsCubit.drugsList[index],
              );
            },
          );
        },
      ),
    );
  }
}
