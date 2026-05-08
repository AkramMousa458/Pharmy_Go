import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/core/utils/dimensions.dart';
import 'package:pharmygo/core/utils/icons.dart';
import 'package:pharmygo/patient/widgets/custom_back_button.dart';
import 'package:pharmygo/patient/widgets/custom_drugs_grid_widget.dart';
import 'package:pharmygo/public/views/ocr_page.dart';
import 'package:pharmygo/public/widgets/custom_search.dart';
import 'package:pharmygo/public/widgets/custom_text_field.dart';

class PatientDrugsListView extends StatelessWidget {
  const PatientDrugsListView({super.key});

  static const routeName = '/PatientDrugsListView';
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Drugs',
          style: TextStyle(
            color: ThemeColors.kMainColor(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: const CustomBackButton(),
      ),
      backgroundColor: ThemeColors.kBackgroundColor(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextField(
            width: Dimensions.screenWidth(context) - 40,
            startIcon: searchIcon,
            endIcon: cameraIcon,
            onTapEndIcon: () {
              Navigator.pushNamed(context, OcrPage.routeName);
            },
            onTap: () {
              showSearch(context: context, delegate: CustomSearch());
            },
          ),
          const Expanded(
            child: CustomDrugsGridView(),
          ),
          SizedBox(
            width: Dimensions.screenWidth(context),
          ),
        ],
      ),
    );
  }
}
