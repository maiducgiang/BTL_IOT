import 'dart:async';

import 'package:btliot/const.dart';
import 'package:btliot/extension/date_formatting.dart';
import 'package:btliot/ui/LandingScreen/components/control_button.dart';
import 'package:btliot/ui/LandingScreen/landing_screen.dart';
import 'package:btliot/ui/connect_host/connect_host.dart';
import 'package:btliot/ui/sensorScreen/widget/card.dart';
import 'package:btliot/ui/sensorScreen/widget/custome_cupertino_alert.dart';
import 'package:btliot/ui/sensorScreen/widget/status_button.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';

class SensorScreenBody extends StatefulWidget {
  @override
  _SensorScreenBodyState createState() => _SensorScreenBodyState();
}

class _SensorScreenBodyState extends State<SensorScreenBody> {
  late DateTime timeNow = DateTime.now();
  late bool connect = false;
  late bool isActiveFan = false;
  late bool isActiveLed = false;
  late bool isActiveWindown = false;
  String doam = "0";
  String nhietdo = "0";
  late Timer _timer;
  // final controller = Get.put(Appcontroller(connect: "false".obs));
  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 4000), (Timer timer) {
      timeNow = DateTime.now();
      print("maiducgiang delay" + doam + "" + nhietdo);
      if (connect == true) {
        client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
          for (int i = 0; i < c!.length; i++) {
            final recMess = c[i].payload as MqttPublishMessage;
            final pt = MqttPublishPayload.bytesToStringAsString(
                recMess.payload.message);
            setState(() {
              if (c[i].topic == "MQTT_ESP32/DOAM") doam = pt;
              if (c[i].topic == "MQTT_ESP32/NHIETDO") nhietdo = pt;
            });
          }
        });
      }
    });

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
                  const Icon(
                    Icons.menu,
                    size: 30,
                    color: kDarkGreyColor,
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
                        pushMess("MQTT_ESP32/QUAT", "0");
                      } else {
                        pushMess("MQTT_ESP32/QUAT", "1");
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
                        pushMess("MQTT_ESP32/DEN", "0");
                      } else {
                        pushMess("MQTT_ESP32/DEN", "1");
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
                        pushMess("MQTT_ESP32/CUA", "0");
                      } else {
                        pushMess("MQTT_ESP32/CUA", "1");
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
                    onTap: () {},
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
