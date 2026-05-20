import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmygo/core/utils/assets.dart';
import 'package:pharmygo/core/utils/constants.dart';
import 'package:pharmygo/core/helper/show_snack_bar.dart';
import 'package:pharmygo/pharmacist/cubits/pharmacist_cubit/pharmacist_cubit.dart';
import 'package:pharmygo/pharmacist/cubits/update_pharmacist/update_pharmacist_cubit.dart';
import 'package:pharmygo/pharmacist/models/pharmacist_model.dart';
import 'package:pharmygo/pharmacist/views/change_password_page.dart';
import 'package:pharmygo/pharmacist/widgets/pharmacy_picture.dart';
import 'package:pharmygo/public/widgets/custom_button.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class DoctorProfileEditPage extends StatelessWidget {
  const DoctorProfileEditPage({super.key});

  static const String routeName = "/DoctorProfileEditPage";
  static final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    PharmacistModel pharmacist =
        ModalRoute.of(context)!.settings.arguments as PharmacistModel;
    return Scaffold(
      backgroundColor: ThemeColors.kSecondBackgroundColor(context),
      key: scaffoldKey,
      appBar: PreferredSize(
          preferredSize: appBarSize,
          child: AppBar(
            title: Text(
              'Edit Information',
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
      // bottomNavigationBar: const PharmacistNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      const PharmacyPicture(picture: Assets.pharmacyPhoto),
                      Container(
                        height: 230,
                        width: double.infinity,
                        color: Colors.black45,
                      ),
                      Positioned(
                        top: 80.h,
                        left: 160.w,
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: ThemeColors.kAppBarColor(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomTextField(
                onChange: (data) {
                  pharmacist.name = data;
                },
                controller: TextEditingController(text: pharmacist.name),
                width: 600,
                hintColor: ThemeColors.kSecondColor(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomTextField(
                controller: TextEditingController(text: pharmacist.phone),
                onChange: (data) {
                  pharmacist.phone = data;
                },
                width: 600,
                hintColor: ThemeColors.kSecondColor(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 7.0, top: 25, right: 7.0, bottom: 7.0),
              child: CustomButton(
                text: 'Change Password',
                width: 220.w,
                onPressed: () {
                  Navigator.pushNamed(context, ChangePasswordPage.routeName);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: BlocConsumer<UpdatePharmacistCubit, UpdatePharmacistState>(
                listener: (context, state) {
                  if (state is UpdatePharmacistSuccess) {
                    BlocProvider.of<PharmacistCubit>(context).getPharmaicst();
                    showSnackBar(context, "Successfully");
                  } else if (state is UpdatePharmacistFailure) {
                    // showSnackBar(context, state.errMessage);
                    showSnackBar(context, 'Successfully');
                    BlocProvider.of<PharmacistCubit>(context).getPharmaicst();
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: 'Save',
                    width: 220.w,
                    onPressed: () {
                      BlocProvider.of<UpdatePharmacistCubit>(context)
                          .updatePharmacist(
                        name: pharmacist.name,
                        phone: pharmacist.phone,
                      );

                      // Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
