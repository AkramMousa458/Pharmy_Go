import 'package:flutter/material.dart';
import 'package:pharmygo/core/theme/theme_colors.dart';

class SwitchItem extends StatefulWidget {
  final String title; // إضافة معامل العنوان
  final String subtitle; // إضافة معامل العنوان الفرعي

  const SwitchItem({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  State<SwitchItem> createState() => _SwitchItemState();
}

class _SwitchItemState extends State<SwitchItem> {
  bool isSelected = false;
  void itemSwitch(bool value) {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            // Navigator.pushNamed(context, SetAlarmPage.routeName);
          },
          title: Text(
            widget.title, // استخدم العنوان الممرر
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(widget.subtitle), // استخدم العنوان الفرعي الممرر
          trailing: Switch(
            value: isSelected,
            onChanged: itemSwitch,
            activeColor: ThemeColors.kMainButtonColor(context),
          ),
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
