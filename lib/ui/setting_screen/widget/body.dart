import 'dart:async';

import 'package:btliot/const.dart';
import 'package:btliot/extension/date_formatting.dart';
import 'package:btliot/extension/get_color.dart';
import 'package:btliot/ui/LandingScreen/components/control_button.dart';
import 'package:btliot/ui/LandingScreen/landing_screen.dart';
import 'package:btliot/ui/connect_host/connect_host.dart';
import 'package:btliot/ui/get_time/get_time.dart';
import 'package:btliot/ui/sensorScreen/widget/card.dart';
import 'package:btliot/ui/sensorScreen/widget/custome_cupertino_alert.dart';
import 'package:btliot/ui/sensorScreen/widget/status_button.dart';
import 'package:btliot/ui/setting_screen/widget/card_custome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mqtt_client/mqtt_client.dart';

class SettingBody extends StatefulWidget {
  @override
  _SettingBodyState createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody>
    with TickerProviderStateMixin {
  late DateTime timeNow = DateTime.now();
  late bool connect = false;
  late bool isActiveFan = false;
  late bool isActiveLed = false;
  late bool isActiveWindown = false;
  String doam = "0";
  late TabController tabController;
  String nhietdo = "0";
  late Timer _timer;
  // final controller = Get.put(Appcontroller(connect: "false".obs));
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
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

    final cerius = 0;
    return Scaffold(
      backgroundColor: Colors.white, //cerius.getColor().opacity,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.08),
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
                Container(
                  height: ,
                  child: TabBarView(
                    children: [Container(), Container()],
                    controller: tabController,
                  ),
                ),
                SizedBox(height: 12),
                //Switch(value: true, onChanged: (value) {}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      },
                      disconect: () async {},
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonCustom(
                      icon: Icons.settings_outlined,
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
                      title: 'Điều khiển \nnâng cao',
                      width: size.width / 2 - 28,
                      isSelected: false,
                    ),
                    ButtonCustom(
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
                      title: 'Điều khiển \nquạt ',
                      icon: Icons.wind_power,
                      isSelected: isActiveFan,
                      width: size.width / 2 - 28,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonCustom(
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
                      title: 'Điều khiển\nđèn',
                      icon: Icons.highlight,
                      isSelected: isActiveLed,
                      width: size.width / 2 - 28,
                    ),
                    ButtonCustom(
                      onTap: () {},
                      title: 'Nhiệt độ\ntrong phòng ',
                      icon: Icons.ac_unit,
                      isSelected: true,
                      width: size.width / 2 - 28,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonCustom(
                      onTap: () {},
                      title: 'Độ ẩm \ntrong phòng',
                      icon: Icons.water_drop_outlined,
                      isSelected: true,
                      width: size.width / 2 - 28,
                    ),
                    ButtonCustom(
                      onTap: () {},
                      title: 'Độ ẩm \ntrong phòng',
                      icon: Icons.water_drop_outlined,
                      isSelected: true,
                      width: size.width / 2 - 28,
                    ),
                  ],
                ),

                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build1(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            children: [
              SizedBox(height: 12),
              //Switch(value: true, onChanged: (value) {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      StatusButton2(
                        size: MediaQuery.of(context).size,
                        isActive: connect,
                      ),
                      StatusButton2(
                        size: MediaQuery.of(context).size,
                        isActive: connect,
                        title: "Bluetooth",
                      ),
                    ],
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
              SizedBox(height: 12),
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
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => const GetTime()),
                      // );
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
