import 'package:btliot/const.dart';
import 'package:btliot/ui/LandingScreen/components/default_button.dart';
import 'package:btliot/ui/home_page/home_page.dart';
import 'package:btliot/ui/sensorScreen/sensor_screen.dart';
import 'package:btliot/widget/text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailForgotController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kBgColor,
          automaticallyImplyLeading: false,
          title: const Text(
            "Mã thiết bị",
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
        ),
        body: Container(
            padding: EdgeInsets.zero,
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: ListView(
              children: [renderHeader(), renderBody(context)],
            )));
  }

  Widget renderBody(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldInput(
              hinText: 'nhập mã thiết bị',
              controller: emailForgotController,
            ),
            SizedBox(
              height: 24,
            ),
            DefaultButton(
              size: size,
              title: "Gửi",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget renderHeader() {
    return Container(
      height: 150,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: const Text(
        "Hãy điền mã thiết bị của bạn. Bạn sẽ nhận được một kết nối tới ngôi nhà thông minh của bạn.",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w300,
            height: 1.3),
      ),
    );
  }
}
