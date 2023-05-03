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
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  Widget build1(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final cerius = 0;
    return Scaffold(
      backgroundColor: Colors.white, //cerius.getColor().opacity,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.08),

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
                SizedBox(height: size.height * 0.08),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'TEMPERATURE',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icon_hot.svg",
                                    color: Colors.grey,
                                    width: 80,
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  Text(
                                    "$nhietdo°",
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 14),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'HUMIDITY',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 23,
                          ),
                          Row(
                            children: [
                              if (int.parse(doam) < 40)
                                SvgPicture.asset(
                                  "assets/humidity_low.svg",
                                  color: Colors.grey,
                                  width: 60,
                                )
                              else if (int.parse(doam) < 80)
                                SvgPicture.asset(
                                  "assets/humidity_mid.svg",
                                  color: Colors.grey,
                                  width: 60,
                                )
                              else
                                SvgPicture.asset(
                                  "assets/humidity_high.svg",
                                  color: Colors.grey,
                                  width: 60,
                                ),
                              const SizedBox(
                                width: 24,
                              ),
                              Text(
                                '$doam%',
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 26,
                    ),
                    SizedBox(
                      height: 130,
                      child: Text(
                        cerius.toString(),
                        style: TextStyle(
                            color: cerius.getColor(),
                            fontSize: 130,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        "°C",
                        style: TextStyle(
                            color: cerius.getColor(),
                            fontSize: 26,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                // Container(
                //   alignment: Alignment.center,
                //   child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         if (cerius < 30) ...[
                //           SvgPicture.asset(
                //             "assets/icon_cold.svg",
                //             color: cerius.getColor(),
                //             width: 40,
                //           ),
                //           SizedBox(
                //             width: 5,
                //           ),
                //           Text("Nhiệt độ mát",
                //               style: TextStyle(
                //                 color: cerius.getColor(),
                //                 fontSize: 20,
                //                 fontWeight: FontWeight.w500,
                //               ))
                //         ] else ...[
                //           SvgPicture.asset(
                //             "assets/icon_hot.svg",
                //             color: cerius.getColor(),
                //             width: 40,
                //           )
                //         ],
                //       ]),
                // ),
                SizedBox(height: size.height * 0.05),
                //Switch(value: true, onChanged: (value) {}),
                /*Row(
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
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const GetTime()),
                        // );
                      },
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
