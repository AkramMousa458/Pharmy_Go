import 'package:flutter/material.dart';
import 'package:pharmygo/public/widgets/custom_done.dart';

class DonePharmacistRegisterationView extends StatelessWidget {
  const DonePharmacistRegisterationView({super.key});
  static String routeName = "DonePharmacistRegisterationView";

  @override
  Widget build(BuildContext context) {
    return const CustomDone(isText: true,);
  }
}
