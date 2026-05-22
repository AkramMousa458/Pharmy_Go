import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/colors.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/views/people_screen.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_medcines_cubit/get_my_medcines_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_pharmacies_cubit/get_my_pharmacies_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/get_shortage_drug_cubit/get_shortage_drug_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/pharmacist_cubit/pharmacist_cubit.dart';
import 'package:pharmygo/pharmacist/models/pharmacy_model.dart';
import 'package:pharmygo/pharmacist/views/pharmacist_pages/shortage_drugs_list.dart';
import 'package:pharmygo/pharmacist/widgets/custom_pharmacist_drawer.dart';
import 'package:pharmygo/pharmacist/widgets/custom_search_for_pharmacist.dart';
import 'package:pharmygo/public/cubits/fetch_drugs_cubit/fetch_drugs_cubit.dart';
import 'package:pharmygo/public/widgets/custom_app_bar.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class PharmacistHomePage extends StatefulWidget {
  const PharmacistHomePage({super.key});

  static const routeName = '/PharmacistAddListView';
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<PharmacistHomePage> createState() => _PharmacistHomePageState();
}

class _PharmacistHomePageState extends State<PharmacistHomePage> {
  String _dropdownValue = 'No pharmacies yet';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PharmacistCubit>(context).getPharmaicst().then((void _) {
      if (!mounted) return;
      BlocProvider.of<GetMyPharmaciesCubit>(context)
          .getMyPharmacies()
          .then((void _) {
        if (!mounted) return;
        BlocProvider.of<GetShortageDrugCubit>(context).getShortageDrugs(
            pharmacyId: BlocProvider.of<GetMyPharmaciesCubit>(context)
                .choosenPharmacy
                .id);
        BlocProvider.of<GetMyMedcinesCubit>(context).getMyMedcines(
            pharmacyId: BlocProvider.of<GetMyPharmaciesCubit>(context)
                .choosenPharmacy
                .id);
        setState(() {
          if (BlocProvider.of<GetMyPharmaciesCubit>(context)
              .myPharmacies
              .isNotEmpty) {
            _dropdownValue = BlocProvider.of<GetMyPharmaciesCubit>(context)
                .choosenPharmacy
                .pharmacyName;
          } else {
            _dropdownValue = 'No pharmacies yet';
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: PharmacistHomePage.scaffoldKey,
      backgroundColor: ThemeColors.kBackgroundColor(context),
      drawer: const Drawer(
        child: CustomPharmacistDrawer(),
      ),
      appBar: PreferredSize(
        preferredSize: appBarSize,
        child: CustomAppBar(
          scaffoldKey: PharmacistHomePage.scaffoldKey,
          endIcon: FontAwesomeIcons.message,
          endIconAction: () {
            Navigator.pushNamed(context, PeopleScreen.routeName,
                arguments: 'doctor');
          },
        ),
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
                  onTap: () {
                    showSearch(
                        context: context,
                        delegate: CustomSearchForPharmacist());
                  },
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
                  "My Pharmacies",
                  style: TextStyle(color: ThemeColors.kMainColor(context)),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 180.w,
                  child:
                      BlocBuilder<GetMyPharmaciesCubit, GetMyPharmaciesState>(
                    builder:
                        (BuildContext context, GetMyPharmaciesState state) {
                      if (state is GetMyPharmaciesFailure) {
                        return Text(state.errMessage);
                      } else if (state is GetMyPharmaciesSuccsess) {
                        if (state.myPharmacies.isEmpty) {
                          return Text(
                            'No pharmacies yet',
                            style: TextStyle(
                              color: ThemeColors.kMainColor(context),
                              fontSize: 14.sp,
                            ),
                          );
                        }
                        final List<String> pharmacyNames = state.myPharmacies
                            .map((PharmacyModel pharmacy) =>
                                pharmacy.pharmacyName)
                            .toList();
                        if (!pharmacyNames.contains(_dropdownValue)) {
                          _dropdownValue = pharmacyNames.first;
                        }
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
                            if (newValue != null) {
                              _dropdownValue = newValue;
                              BlocProvider.of<GetMyPharmaciesCubit>(context)
                                      .choosenPharmacy =
                                  state.myPharmacies.firstWhere(
                                      (PharmacyModel element) =>
                                          element.pharmacyName ==
                                          _dropdownValue);
                              BlocProvider.of<GetShortageDrugCubit>(context)
                                  .getShortageDrugs(
                                      pharmacyId:
                                          BlocProvider.of<GetMyPharmaciesCubit>(
                                                  context)
                                              .choosenPharmacy
                                              .id);
                              BlocProvider.of<FetchDrugsCubit>(context)
                                  .fetchDrugs();
                            }
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
          const ShortageDrugsList(),
          // const Expanded(
          //   child: AddButtonList(),
          // ),
        ],
      ),
    );
  }
}
