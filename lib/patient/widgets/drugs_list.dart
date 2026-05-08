import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/patient/cubits/update_patient_location/update_patient_location_cubit.dart';
import 'package:pharmygo/public/models/drug_model.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class DrugsList extends StatefulWidget {
  const DrugsList(
      {super.key,
      required this.drug,
      required this.index,
      required this.onTap});
  final List<DrugModel> drug;
  final int index;
  final void Function() onTap;

  @override
  State<DrugsList> createState() => _DrugsListState();
}

class _DrugsListState extends State<DrugsList> {
  @override
  void initState() {
    BlocProvider.of<UpdatePatientLocationCubit>(context)
        .updatePatientLocation(longitude: '', latitude: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Container(
          height: 180,
          width: 150,
          decoration: BoxDecoration(
            color: ThemeColors.kSecondBackgroundColor(context),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  imageUrl: widget.drug[widget.index].imageUrl,
                  fit: BoxFit.cover,
                  height: Dimensions.screenWidth(context) / 2.6,
                  width: Dimensions.screenWidth(context) / 3,
                  placeholder: (context, url) =>
                      const Center(child: CustomLoadingIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.drug[widget.index].nameEn,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
