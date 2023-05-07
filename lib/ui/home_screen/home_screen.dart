import 'package:btliot/const.dart';
import 'package:btliot/ui/board/board_screen.dart';
import 'package:btliot/ui/profile/profile_screen.dart';
import 'package:btliot/ui/sensorScreen/sensor_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var tabIndex = 0;

  final _screenList = [SensorScreen(), const BoardScreen(), ProfileScreen()];

  void changeTabIndex(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  getScreen() => _screenList[tabIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScreen(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: changeTabIndex,
          currentIndex: tabIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kOrangeColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle:
              TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 6, top: 6),
                  child: SvgPicture.asset(
                    "assets/home.svg",
                    color: Colors.grey,
                    width: 42,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 6, top: 6),
                  child: SvgPicture.asset(
                    "assets/home.svg",
                    color: kOrangeColor,
                    width: 42,
                  ),
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 6, top: 6),
                  child: SvgPicture.asset(
                    "assets/schedule.svg",
                    color: Colors.grey,
                    width: 32,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 6, top: 6),
                  child: SvgPicture.asset(
                    "assets/schedule.svg",
                    color: kOrangeColor,
                    width: 32,
                  ),
                ),
                label: 'Schedule'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 6, top: 6),
                  child: SvgPicture.asset(
                    "assets/settings.svg",
                    color: Colors.grey,
                    width: 36,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 6, top: 6),
                  child: SvgPicture.asset(
                    "assets/settings.svg",
                    color: kOrangeColor,
                    width: 36,
                  ),
                ),
                label: 'Setting'),
          ],
        ),
      ),
    );
  }
}
