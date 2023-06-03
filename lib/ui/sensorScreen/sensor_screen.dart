import 'package:demoios/const.dart';

import 'package:demoios/ui/sensorScreen/widget/body.dart';
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
