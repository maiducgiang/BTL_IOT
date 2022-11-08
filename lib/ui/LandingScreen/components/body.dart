import 'package:btliot/const.dart';
import 'package:btliot/ui/LandingScreen/components/control_button.dart';
import 'package:btliot/ui/LandingScreen/components/default_button.dart';
import 'package:btliot/ui/LandingScreen/components/page_view_welcome.dart';
import 'package:btliot/ui/connect_host/connect_host.dart';
import 'package:btliot/ui/get_time/get_time.dart';
import 'package:btliot/ui/sensorScreen/sensor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingScreenBody extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LandingScreenBodyState createState() => _LandingScreenBodyState();
}

class _LandingScreenBodyState extends State<LandingScreenBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nâng cao',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        leading: InkWell(
          onTap: (() {
            Navigator.pop(context);
          }),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: kDarkGreyColor,
          ),
        ),
        backgroundColor: kBgColor,
        elevation: 0,
      ),
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 30),
              const PageViewWelcome(),
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ControlButton(
                    size: size,
                    title: 'Bật tắt\ntheo ánh sáng',
                    icon: Icons.highlight_outlined,
                    disapble: true,
                    onTap: () async {
                      await main();
                    },
                  ),
                  ControlButton(
                    size: size,
                    title: 'Tắt đèn \ntự động ',
                    icon: Icons.lightbulb_outline,
                    disapble: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GetTime()),
                      );
                    },
                  ),
                  ControlButton(
                    size: size,
                    disapble: true,
                    title: 'Bật đèn \ntự động',
                    icon: Icons.highlight,
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ControlButton(
                    size: size,
                    title: 'Đóng cửa \nkhi trời mưa',
                    icon: Icons.window_outlined,
                    onTap: () {},
                    disapble: true,
                  ),
                  ControlButton(
                    size: size,
                    title: 'Hẹn giờ\nđóng cửa',
                    icon: Icons.sensor_window_outlined,
                    onTap: () {},
                    disapble: true,
                  ),
                  ControlButton(
                    size: size,
                    disapble: true,
                    title: 'Hẹn giờ\nmở cửa',
                    icon: Icons.sensor_window_rounded,
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ControlButton(
                    size: size,
                    title: 'Bật tắt theo\nnhiệt độ',
                    icon: Icons.wind_power,
                    onTap: () {},
                    disapble: true,
                  ),
                  ControlButton(
                    size: size,
                    title: 'Hẹn giờ\nbật',
                    icon: Icons.wind_power_rounded,
                    onTap: () {},
                    disapble: true,
                  ),
                  ControlButton(
                    size: size,
                    title: 'Hẹn giờ\ntắt',
                    icon: Icons.wind_power_outlined,
                    onTap: () {},
                    disapble: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
