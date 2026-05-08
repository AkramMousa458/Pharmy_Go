import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class ChooseRepeat extends StatefulWidget {
   const ChooseRepeat({super.key});

  @override
  State<ChooseRepeat> createState() => _ChooseRepeatState();
}

class _ChooseRepeatState extends State<ChooseRepeat> {
  // The group value
  // ignore: prefer_typing_uninitialized_variables
  var _result;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
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
        RadioListTile(
            title:  Text(
              'Every Saturday',
              style: TextStyle(
                fontSize: 25,
                color: ThemeColors.kMainColor(context),
              ),
            ),
            value: "every saturday,",
            groupValue: _result,
            onChanged: (value) {
              setState(() {
                _result = value;
              });
            }),
        RadioListTile(
            title:  Text(
              'Every Sunday',
              style: TextStyle(
                fontSize: 25,
                color: ThemeColors.kMainColor(context),
              ),
            ),
            value: "every sunday",
            groupValue: _result,
            onChanged: (value) {
              setState(() {
                _result = value;
              });
            }),
        RadioListTile(
            title:  Text(
              'Every Monday',
              style: TextStyle(
                fontSize: 25,
                color: ThemeColors.kMainColor(context),
              ),
            ),
            value: "every monday",
            groupValue: _result,
            onChanged: (value) {
              setState(() {
                _result = value;
              });
            }),
        RadioListTile(
            title:  Text(
              'Every Tuesday',
              style: TextStyle(
                fontSize: 25,
                color: ThemeColors.kMainColor(context),
              ),
            ),
            value: "Every Tuesday",
            groupValue: _result,
            onChanged: (value) {
              setState(() {
                _result = value;
              });
            }),
        RadioListTile(
            title:  Text(
              'Every Wednesday',
              style: TextStyle(
                fontSize: 25,
                color: ThemeColors.kMainColor(context),
              ),
            ),
            value: "every wednesday",
            groupValue: _result,
            onChanged: (value) {
              setState(() {
                _result = value;
              });
            }),
        RadioListTile(
            title:  Text(
              'Every Thursday',
              style: TextStyle(
                fontSize: 25,
                color: ThemeColors.kMainColor(context),
              ),
            ),
            value: "Every Thursday",
            groupValue: _result,
            onChanged: (value) {
              setState(() {
                _result = value;
              });
            }),
        RadioListTile(
            title:  Text(
              'Every Friday',
              style: TextStyle(
                fontSize: 25,
                color: ThemeColors.kMainColor(context),
              ),
            ),
            value: "every friday",
            groupValue: _result,
            onChanged: (value) {
              setState(() {
                _result = value;
              });
            }),
         const SizedBox(height: 25),
      ],
    );
  }
}
