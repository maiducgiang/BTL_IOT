import 'package:btliot/const.dart';
import 'package:btliot/ui/components/body.dart';
import 'package:flutter/material.dart';

class SensorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SensorScreenBody(),
    );
  }
}
