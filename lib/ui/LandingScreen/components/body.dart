import 'package:btliot/const.dart';
import 'package:btliot/ui/LandingScreen/components/control_button.dart';
import 'package:btliot/ui/LandingScreen/components/default_button.dart';
import 'package:btliot/ui/components/sensor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandingScreenBody extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LandingScreenBodyState createState() => _LandingScreenBodyState();
}

class _LandingScreenBodyState extends State<LandingScreenBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: size.height * 0.1),
          const Center(
            child: Text(
              'Chào mừng!\nĐến với ứng dụng nhà thông minh',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 36,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.05),
          const Center(
            child: Text(
              'Ứng dụng giúp điều khiển ngôi nhà\n thông minh của bạn',
              textAlign: TextAlign.center,
              style: TextStyle(color: kDarkGreyColor, fontSize: 23),
            ),
          ),
          SizedBox(height: size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ControlButton(
                size: size,
                title: 'Maintenance\nRequests',
                icon: Icons.settings_outlined,
              ),
              ControlButton(
                size: size,
                title: 'Integrations\n ',
                icon: Icons.grain,
              ),
              ControlButton(
                size: size,
                title: 'Light\nControl',
                icon: Icons.highlight,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ControlButton(
                size: size,
                title: 'Leak\nDetector',
                icon: Icons.opacity,
              ),
              ControlButton(
                size: size,
                title: 'Temperature\nControl ',
                icon: Icons.ac_unit,
              ),
              ControlButton(
                size: size,
                title: 'Guest\nAccess',
                icon: Icons.vpn_key,
              ),
            ],
          ),
          SizedBox(height: size.height * 0.05),
          DefaultButton(
            size: size,
            title: "Next",
            press: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => SensorScreen(),
                ),
              );
            },
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }
}
