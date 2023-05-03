import 'package:btliot/const.dart';

import 'package:btliot/ui/setting_screen/widget/body.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SettingBody(),
    );
  }
}
