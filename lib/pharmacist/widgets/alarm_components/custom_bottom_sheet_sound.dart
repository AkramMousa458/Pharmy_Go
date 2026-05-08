import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class ChooseSound extends StatefulWidget {
   const ChooseSound({super.key});

  @override
  State<ChooseSound> createState() => _ChooseSoundState();
}

class _ChooseSoundState extends State<ChooseSound> {
  // The group value
  // ignore: prefer_typing_uninitialized_variables
  var _result1;
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
              'Sound1',
              style: TextStyle(
                fontSize: 25,
                color: ThemeColors.kMainColor(context),
              ),
            ),
            value: "Sound1",
            groupValue: _result1,
            onChanged: (value) {
              setState(() {
                _result1 = value;
              });
            }),
        RadioListTile(
            title:  Text(
              'Sound2',
              style: TextStyle(
                fontSize: 25,
                color: ThemeColors.kMainColor(context),
              ),
            ),
            value: "Sound2",
            groupValue: _result1,
            onChanged: (value) {
              setState(() {
                _result1 = value;
              });
            }),
        RadioListTile(
            title:  Text(
              'Sound3',
              style: TextStyle(
                fontSize: 25,
                color: ThemeColors.kMainColor(context),
              ),
            ),
            value: "Sound3",
            groupValue: _result1,
            onChanged: (value) {
              setState(() {
                _result1 = value;
              });
            }),
        RadioListTile(
            title:  Text(
              'Sound4',
              style: TextStyle(
                fontSize: 25,
                color: ThemeColors.kMainColor(context),
              ),
            ),
            value: "Sound4",
            groupValue: _result1,
            onChanged: (value) {
              setState(() {
                _result1 = value;
              });
            }),
         const SizedBox(height: 25),
      ],
    );
  }
}
