import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatetimeSelect extends StatelessWidget{
  final void Function(DateTime t) onChanged;
  final DateTime time;

  DatetimeSelect({super.key, required this.time, required this.onChanged});
  
  @override
  Widget build(BuildContext context) {
    final dFormat = DateFormat("yyyy-MM-dd");
    final tFormat = DateFormat("HH:mm:ss");
    final bStyle = TextButton.styleFrom(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        fontFeatures: [FontFeature.tabularFigures()],
      )
    );

    return Row(children: [
        TextButton(onPressed: input, style: bStyle, child: Text(dFormat.format(time))),
        TextButton(onPressed: input, style: bStyle, child: Text(tFormat.format(time))),
      ]);
  }

  void input(){

  }
}
