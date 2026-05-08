import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';
import 'package:pharmygo/pharmacist/widgets/alarm_components/custom_bottom_sheet_repeat.dart';

class ChooseTypeOfRepeat extends StatefulWidget {
   const ChooseTypeOfRepeat({super.key});

  @override
  State<ChooseTypeOfRepeat> createState() => _ChooseTypeOfRepeatState();
}

class _ChooseTypeOfRepeatState extends State<ChooseTypeOfRepeat> {
  // The selected value
  String? selectedValue;

  void showRepeat(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        builder: (ctx) => Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  const EdgeInsets.all(16.0),
              child: Text(
                'Choose',
                style: TextStyle(
                  fontSize: 25,
                  color: ThemeColors.kMainColor(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        CheckboxListTile(
          title: Text(
            'Once',
            style: TextStyle(
              fontSize: 25,
              color: ThemeColors.kMainColor(context),
            ),
          ),
          value: selectedValue == 'Once',
          onChanged: (value) {
            setState(() {
              selectedValue = value! ? 'Once' : null;
            });
          },
        ),
        CheckboxListTile(
          title: Text(
            'Daily',
            style: TextStyle(
              fontSize: 25,
              color: ThemeColors.kMainColor(context),
            ),
          ),
          value: selectedValue == 'Daily',
          onChanged: (value) {
            setState(() {
              selectedValue = value! ? 'Daily' : null;
            });
          },
        ),
        CheckboxListTile(
          title: Text(
            'Mon to Fri',
            style: TextStyle(
              fontSize: 25,
              color: ThemeColors.kMainColor(context),
            ),
          ),
          value: selectedValue == 'Mon to Fri',
          onChanged: (value) {
            setState(() {
              selectedValue = value! ? 'Mon to Fri' : null;
            });
          },
        ),
        CheckboxListTile(
          title: Text(
            'Custom',
            style: TextStyle(
              fontSize: 25,
              color: ThemeColors.kMainColor(context),
            ),
          ),
          value: selectedValue == 'Custom',
          onChanged: (value) {
            setState(() {
              selectedValue = value! ? 'Custom' : null;
              Navigator.pop(context);
              showRepeat(context); // Call showRepeat directly
            });
          },
        ),
         const SizedBox(height: 25),
      ],
    );
  }
}
