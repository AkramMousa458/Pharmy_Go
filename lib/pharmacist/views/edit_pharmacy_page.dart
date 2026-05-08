import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/core/utils/colors.dart';
import 'package:pharmygo/pharmacist/cubits/get_my_pharmacies_cubit/get_my_pharmacies_cubit.dart';
import 'package:pharmygo/pharmacist/widgets/edit_pharmacy_bottom_sheet.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';

class EditPharmacyPage extends StatefulWidget {
  const EditPharmacyPage({super.key});

  static String routeName = "/EditPharmacyPage";
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<EditPharmacyPage> createState() => _EditPharmacyPageState();
}

class _EditPharmacyPageState extends State<EditPharmacyPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<GetMyPharmaciesCubit>(context).getMyPharmacies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      key: EditPharmacyPage.scaffoldKey,
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 50),
          child: AppBar(
            title: Text(
              'My Pharmacies',
              style: TextStyle(
                color: ThemeColors.kMainColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: ThemeColors.kMainColor(context)),
            ),
          )),
      // bottomNavigationBar:  PharmacistNavigationBar(),
      body: Column(children: [
        SizedBox(
          height: 500.h,
          child: BlocBuilder<GetMyPharmaciesCubit, GetMyPharmaciesState>(
            builder: (context, state) {
              if (state is GetMyPharmaciesSuccsess) {
                return ListView.builder(
                    itemCount: state.myPharmacies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Text(
                                  state.myPharmacies[index].pharmacyName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: kMainColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: 190.w,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  color: ThemeColors.kMainColor(context),
                                  onPressed: () {
                                    editPharmacyBottomSheet(
                                        context: context,
                                        pharmacyModel:
                                            state.myPharmacies[index]);
                                    // pharmacyDetailsBottomSheet(context: context);
                                  },
                                ),
                                IconButton(
                                  icon: const FaIcon(FontAwesomeIcons.trashCan),
                                  color: ThemeColors.kAlarmColor(context),
                                  onPressed: () {
                                    // editPharmacyBottomSheet(
                                    //     context: context,
                                    //     pharmacyModel:
                                    //         state.myPharmacies[index]);
                                    // pharmacyDetailsBottomSheet(context: context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    });
              }
              return const Center(child: CustomLoadingIndicator());
            },
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        CustomButton(
          text: 'Save',
          width: 250,
          onPressed: () {
            showSnackBar(context, "Saved");
            Navigator.pop(context);
          },
        ),
        // const Spacer(flex: 1),
      ]),
    );
  }
}
