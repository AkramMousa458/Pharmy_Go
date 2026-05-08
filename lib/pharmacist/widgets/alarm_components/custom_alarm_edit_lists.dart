import 'package:flutter/material.dart';
import 'package:pharmygo/pharmacist/widgets/alarm_components/custom_bottom_sheet_repeat.dart';
import 'package:pharmygo/pharmacist/widgets/alarm_components/custom_bottom_sheet_sound.dart';
import 'package:pharmygo/pharmacist/widgets/alarm_components/custom_bottom_sheet_type_repeat.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class AlarmEditLists extends StatelessWidget {
   const AlarmEditLists({super.key});

  void showLabel(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  const EdgeInsets.all(16.0),
                        child: Text(
                          'Label Name',
                          style: TextStyle(
                            fontSize: 25,
                            color: ThemeColors.kMainColor(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                   const TextField(
                    keyboardType: TextInputType.name,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:  const EdgeInsets.only(
                            right: 30, bottom: 20, top: 30),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeColors.kMainColor(context),
                            ),
                            child:  Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 20,
                                color: ThemeColors.kTextColor(context),
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }

  void showRepeat(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const ChooseRepeat(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:  const EdgeInsets.only(right: 30, bottom: 20),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeColors.kMainColor(context),
                            ),
                            child:  Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 20,
                                color: ThemeColors.kTextColor(context),
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }

  void showsound(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const ChooseSound(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:  const EdgeInsets.only(right: 30, bottom: 20),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeColors.kMainColor(context),
                            ),
                            child:  Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 20,
                                color: ThemeColors.kTextColor(context),
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }

  void showRepeatType(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 15),
              child:  const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChooseTypeOfRepeat(),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.kBackgroundColor(context),
        bottomSheet: Column(
          children: [
            Divider(
              thickness: 2,
              height: 0,
              indent: 10,
              endIndent: 20,
              color: ThemeColors.kSecondColor(context),
            ),
            GestureDetector(
              onTap: () => showRepeatType(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Text(
                      'Repeat',
                      style: TextStyle(
                        fontSize: 25,
                        color: ThemeColors.kMainColor(context),
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: ThemeColors.kSecondColor(context),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 2,
              height: 0,
              indent: 10,
              endIndent: 20,
              color: ThemeColors.kSecondColor(context),
            ),
            GestureDetector(
              onTap: () => showsound(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Text(
                      'Sound',
                      style: TextStyle(
                        fontSize: 25,
                        color: ThemeColors.kMainColor(context),
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: ThemeColors.kSecondColor(context),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 2,
              height: 0,
              indent: 10,
              endIndent: 20,
              color: ThemeColors.kSecondColor(context),
            ),
            GestureDetector(
              onTap: () => showLabel(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Text(
                      'Label',
                      style: TextStyle(
                        fontSize: 25,
                        color: ThemeColors.kMainColor(context),
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: ThemeColors.kSecondColor(context),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 2,
              height: 0,
              indent: 10,
              endIndent: 20,
              color: ThemeColors.kSecondColor(context),
            ),
          ],
        ));
  }
}
