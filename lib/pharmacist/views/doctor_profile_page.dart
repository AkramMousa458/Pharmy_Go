import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmygo/core/utils/assets.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/pharmacist/cubits/pharmacist_cubit/pharmacist_cubit.dart';
import 'package:pharmygo/pharmacist/views/add_pharmacy_page.dart';
import 'package:pharmygo/pharmacist/views/doctor_edit_profile_page.dart';
import 'package:pharmygo/pharmacist/views/edit_pharmacy_page.dart';
import 'package:pharmygo/pharmacist/widgets/doctor_profile_button.dart';
import 'package:pharmygo/pharmacist/widgets/pharmacy_picture.dart';
import 'package:pharmygo/public/widgets/custom_loading_indicator.dart';
import 'package:pharmygo/public/widgets/data_show.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  static const String routeName = "/DoctorProfilePage";
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: appBarSize,
        child: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(
              color: ThemeColors.kMainColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: BlocBuilder<PharmacistCubit, PharmacistState>(
        builder: (context, state) {
          if (state is FetchPharmacistSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const PharmacyPicture(picture: Assets.pharmacyPhoto)
                  // Container(
                  //   decoration: const BoxDecoration(color: Color(0xFF0B3490)),
                  //   height: 230,
                  // ),
                  ,
                  DataShow(
                    icon: profileIcon,
                    data: state.pharmacist.name,
                    // width: 600,
                    // hintColor:  ThemeColors.kSecondColor(context),
                  ),
                  DataShow(
                    icon: emailIcon,
                    data: state.pharmacist.email,
                    // width: 600,
                    // hintColor:  ThemeColors.kSecondColor(context)
                  ),
                  DataShow(
                    icon: mobileIcon,
                    data: state.pharmacist.phone,
                    // width: 600,
                    // hintColor:  ThemeColors.kSecondColor(context),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 7.0, top: 25, right: 7.0, bottom: 7.0),
                      child: DoctorProfileBtn(
                        text: 'Edit Information',
                        onPressed: () {
                          Navigator.pushNamed(
                              context, DoctorProfileEditPage.routeName,
                              arguments: state.pharmacist);
                        },
                        icon: FontAwesomeIcons.userEdit,
                        width: 325,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: DoctorProfileBtn(
                      text: 'My Pharmacies',
                      onPressed: () {
                        Navigator.pushNamed(
                            context, EditPharmacyPage.routeName);
                      },
                      icon: phramcyIcon,
                      width: 325,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: DoctorProfileBtn(
                        text: 'Add Pharmacy',
                        icon: plusIcon,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AddPharmacyPage.routeName);
                        },
                        width: 325,
                      )),
                ],
              ),
            );
          } else if (state is FetchPharmacistLoading) {
            return const CustomLoadingIndicator();
          } else if (state is FetchPharmacistFailure) {
            return Text(state.errMesage);
          } else {
            return const CustomLoadingIndicator();
          }
        },
      ),
    );
  }
}
