import 'package:btliot/const.dart';
import 'package:btliot/extension/date_formatting.dart';
import 'package:flutter/material.dart';

class SensorScreenBody extends StatefulWidget {
  @override
  _SensorScreenBodyState createState() => _SensorScreenBodyState();
}

class _SensorScreenBodyState extends State<SensorScreenBody> {
  late DateTime timeNow = DateTime.now();
  @override
  void initState() {
    timeNow = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
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
                    fontSize: 20,
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
                Container(
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
                    children: const [
                      Text(
                        '40°',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'TEMPERATURE',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '59%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'HUMIDITY',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
