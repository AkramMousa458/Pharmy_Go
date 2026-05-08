import 'package:flutter/material.dart';
import 'package:pharmygo/pharmacist/widgets/alarm_components/custom_switch_item.dart';

class AlarmItem {
  final String title;
  final String subtitle;

  const AlarmItem({
    required this.title,
    required this.subtitle,
  });
}

class AlarmsList extends StatelessWidget {
  final List<AlarmItem> alarmItems; // القائمة من العناصر

  const AlarmsList({
    required this.alarmItems,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: alarmItems.length,
      itemBuilder: (context, index) {
        final alarmItem = alarmItems[index];
        return SwitchItem(
          title: alarmItem.title,
          subtitle: alarmItem.subtitle,
        );
      },
    );
  }
}

// Example usage:
final List<AlarmItem> alarmItems = [
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
  const AlarmItem(title: '00.00', subtitle: 'Alarm, Only ring once'),
];
