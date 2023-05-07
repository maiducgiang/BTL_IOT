import 'dart:async';

import 'package:btliot/const.dart';
import 'package:btliot/extension/date_formatting.dart';
import 'package:btliot/ui/LandingScreen/components/control_button.dart';
import 'package:btliot/ui/LandingScreen/landing_screen.dart';
import 'package:btliot/ui/auth.dart';
import 'package:btliot/ui/connect_host/connect_host.dart';
import 'package:btliot/ui/sensorScreen/widget/card.dart';
import 'package:btliot/ui/sensorScreen/widget/custome_cupertino_alert.dart';
import 'package:btliot/ui/sensorScreen/widget/status_button.dart';
import 'package:btliot/ui/signin/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';

class SensorScreenBody extends StatefulWidget {
  @override
  _SensorScreenBodyState createState() => _SensorScreenBodyState();
}

class _SensorScreenBodyState extends State<SensorScreenBody>
    with TickerProviderStateMixin {
  late DateTime timeNow = DateTime.now();
  late bool connect = false;
  late bool isActiveFan = false;
  late bool isActiveLed = false;
  late bool isActiveWindown = false;
  String doam = "0";
  String nhietdo = "0";
  late Timer _timer;
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  late TabController tabController;
  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // final controller = Get.put(Appcontroller(connect: "false".obs));
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    _timer = Timer.periodic(const Duration(milliseconds: 4000), (Timer timer) {
      timeNow = DateTime.now();
      print("maiducgiang delay" + doam + " " + nhietdo);
      if (connect == true) {
        client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
          for (int i = 0; i < c!.length; i++) {
            final recMess = c[i].payload as MqttPublishMessage;
            final pt = MqttPublishPayload.bytesToStringAsString(
                recMess.payload.message);
            setState(() {
              if (c[i].topic == "HUMI") doam = pt;
              if (c[i].topic == "TEMP") nhietdo = pt;
            });
          }
        });
      }
    });
    //  _firebaseMessaging.configure(
    //     onMessage: (message) async{
    //       setState(() {
    //         messageTitle = message["notification"]["title"];
    //         notificationAlert = "New Notification Alert";
    //       });

    //     },
    //     onResume: (message) async{
    //       setState(() {
    //         messageTitle = message["data"]["title"];
    //         notificationAlert = "Application opened from Notification";
    //       });

    //     },
    //   );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        Auth().signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WidgetTree()),
                        );
                      });
                    },
                    child: const Icon(
                      Icons.menu,
                      size: 30,
                      color: kDarkGreyColor,
                    ),
                  ),
                  const Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Container(
                    height: size.height * 0.045,
                    width: size.width * 0.095,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.notifications_none,
                      color: kDarkGreyColor,
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/avata.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //'JUNE 14, 2020',
                        timeNow.toEEEMMMdY(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'Xin chào!\nGiang',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$nhietdo°",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const Text(
                          'TEMPERATURE',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$doam%',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const Text(
                          'HUMIDITY',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusButton2(
                    size: MediaQuery.of(context).size,
                    isActive: connect,
                  ),
                  CustomCard(
                    size: size,
                    icon: Icon(
                      Icons.home_outlined,
                      size: 55,
                      color: Colors.grey.shade400,
                    ),
                    title: "ENTRY",
                    statusOn: "Connected",
                    statusOff: "Disconected",
                    connected: () async {
                      await concectBroker(disconnect: () {
                        setState(() {
                          connect = false;
                        });
                      }, connect: () {
                        setState(() {
                          connect = true;
                        });
                      });

                      // setState(() {
                      //   if (client.connectionStatus!.state ==
                      //       MqttConnectionState.connected) {
                      //     connect = true;
                      //   }
                      // });
                    },
                    disconect: () async {},
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              TabBar(
                controller: tabController,
                isScrollable: true,
                unselectedLabelColor: Colors.black45,
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                labelColor: Colors.grey,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  // insets: EdgeInsets.symmetric(horizontal: 48),
                ),
                tabs: const [
                  Tab(text: 'Đang sử dụng'),
                  Tab(text: 'Đang xử lý'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ControlButton(
                    size: size,
                    title: 'Điều khiển \nnâng cao',
                    icon: Icons.settings_outlined,
                    isSelected: false,
                    //disapble: true,
                    onTap: () {
                      if (connect == false) {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext dialogContext) {
                            return CustomCupertinoAlert(
                              context: context,
                              title: "Chú ý",
                              content:
                                  'Ứng dụng chưa được kết nối. Vui lòng thực hiện kết nối trước khi điều khiển nâng cao',
                              rightButtonTitle: 'Xác nhận',
                              rightAction: () async {
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingScreen()),
                        );
                      }
                    },
                  ),
                  ControlButton(
                    size: size,
                    title: 'Điều khiển \nquạt ',
                    icon: Icons.wind_power,
                    isSelected: isActiveFan,
                    onTap: () {
                      setState(() {
                        isActiveFan = !isActiveFan;
                      });
                      if (isActiveFan == false) {
                        pushMess("FAN", "0");
                      } else {
                        pushMess("FAN", "1");
                      }
                    },
                  ),
                  ControlButton(
                    size: size,
                    title: 'Điều khiển\nđèn',
                    icon: Icons.highlight,
                    isSelected: isActiveLed,
                    onTap: () {
                      setState(() {
                        isActiveLed = !isActiveLed;
                      });
                      if (isActiveFan == false) {
                        pushMess("LED1", "0");
                      } else {
                        pushMess("LED1", "1");
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ControlButton(
                    size: size,
                    title: 'Đóng mở \ncửa sổ',
                    icon: Icons.window_outlined,
                    isSelected: isActiveWindown,
                    onTap: () {
                      setState(() {
                        isActiveWindown = !isActiveWindown;
                      });

                      if (isActiveWindown == false) {
                        pushMess("DOOR", "0");
                      } else {
                        pushMess("DOOR", "1");
                      }
                    },
                  ),
                  ControlButton(
                    size: size,
                    title: 'Nhiệt độ\n trong phòng ',
                    icon: Icons.ac_unit,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   CupertinoPageRoute(
                      //     builder: (context) => SensorScreen(),
                      //   ),
                      // );
                    },
                  ),
                  ControlButton(
                    size: size,
                    title: 'Độ ẩm \ntrong phòng',
                    icon: Icons.water_drop_outlined,
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const GetTime()),
                      // );
                    },
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
