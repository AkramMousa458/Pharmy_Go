import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/utils/colors.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_pharmacies_cubit/get_my_pharmacies_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_pharmacy_orders/get_pharmacy_orders_cubit.dart';
import 'package:pharmygo/pharmacist/models/pharmacy_model.dart';
import 'package:pharmygo/pharmacist/widgets/lists/my_medicines_listview_builder.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class MyMedicinesListView extends StatefulWidget {
  const MyMedicinesListView({super.key});

  static const routeName = '/MyMedicinesViewList';
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<MyMedicinesListView> createState() => _MyMedicinesListViewState();
}

String _dropdownValue = '';

class _MyMedicinesListViewState extends State<MyMedicinesListView> {
  @override
  void initState() {
    BlocProvider.of<GetMyPharmaciesCubit>(context).getMyPharmacies();

    BlocProvider.of<GetPharmacyOrdersCubit>(context).getPharmacyOrders(
        pharmacyId:
            BlocProvider.of<GetMyPharmaciesCubit>(context).choosenPharmacy.id);

    if (BlocProvider.of<GetMyPharmaciesCubit>(context)
        .myPharmacies
        .isNotEmpty) {
      _dropdownValue = BlocProvider.of<GetMyPharmaciesCubit>(context)
          .choosenPharmacy
          .pharmacyName;
    } else {
      _dropdownValue = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MyMedicinesListView.scaffoldKey,
      backgroundColor: ThemeColors.kBackgroundColor(context),
      appBar: AppBar(
        title: Text(
          'Pharmacy Orders',
          style: TextStyle(
            color: ThemeColors.kMainColor(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  endIcon: searchIcon,
                  borderRadius: 100,
                  width: Dimensions.screenWidth(context) * 0.9,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 4),
            child: Row(
              children: [
                Text(
                  "My Pharmacis",
                  style: TextStyle(color: ThemeColors.kMainColor(context)),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 180.w,
                  child:
                      BlocBuilder<GetMyPharmaciesCubit, GetMyPharmaciesState>(
                    builder: (context, state) {
                      if (state is GetMyPharmaciesFailure) {
                        return Text(state.errMessage);
                      } else if (state is GetMyPharmaciesSuccsess) {
                        return DropdownButtonFormField<String>(
                          value: _dropdownValue,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          iconSize: 24.sp,
                          elevation: 16,
                          style: const TextStyle(color: kMainColor),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blueAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            filled: true,
                            fillColor: Colors.blue.withOpacity(0.1),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                          ),
                          onChanged: (String? newValue) {
                            _dropdownValue = newValue!;

                            //Update the Choosen Pharmacy
                            BlocProvider.of<GetMyPharmaciesCubit>(context)
                                    .choosenPharmacy =
                                state.myPharmacies.firstWhere((element) =>
                                    element.pharmacyName == _dropdownValue);

                            //Fetch Drugs in the choosen phamrmacy
                            BlocProvider.of<GetPharmacyOrdersCubit>(context)
                                .getPharmacyOrders(
                                    pharmacyId:
                                        BlocProvider.of<GetMyPharmaciesCubit>(
                                                context)
                                            .choosenPharmacy
                                            .id);
                          },
                          items: state.myPharmacies
                              .map<DropdownMenuItem<String>>(
                                  (PharmacyModel pharmacy) {
                            return DropdownMenuItem<String>(
                              value: pharmacy.pharmacyName,
                              child: Text(pharmacy.pharmacyName),
                            );
                          }).toList(),
                          selectedItemBuilder: (BuildContext context) {
                            return state.myPharmacies
                                .map<Widget>((PharmacyModel pharmacy) {
                              return Center(child: Text(pharmacy.pharmacyName));
                            }).toList();
                          },
                          menuMaxHeight: 200,
                        );
                      } else {
                        return const Text('Loading...');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: MyMedicinesListViewBuilder())
        ],
      ),
    );
  }
}
