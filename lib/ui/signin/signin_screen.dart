import 'package:auto_route/auto_route.dart';
import 'package:btliot/const.dart';
import 'package:btliot/ui/LandingScreen/components/default_button.dart';
import 'package:btliot/ui/sensorScreen/sensor_screen.dart';
import 'package:btliot/ui/signin/widget/forgot_password_screen.dart';
import 'package:btliot/widget/text_form_field.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var items = ['Viet Nam', 'English'];
  String dropdownvalue = 'Viet Nam';
  bool checked = false;
  String? error;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Đăng nhập',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          elevation: 0,
          backgroundColor: kBgColor,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: kBgColor,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                renderHeader(),
                renderBody(context)
              ],
            )));
  }
}

Widget renderBody(BuildContext context) {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Size size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          TextFormFieldInput(
            hinText: 'email',
            isEmail: true,
            //error: error,
            controller: emailController,
          ),
          const SizedBox(
            height: 12,
          ),
          TextFormFieldInput(
            isPass: true,
            hinText: 'mật khẩu',
            controller: passwordController,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (() {}),
                child: Text(' Quyên mật khẩu?',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange[900],
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          DefaultButton(
            size: size,
            title: "Đăng nhập",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen()),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text('Chưa có tài khoản? ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
              GestureDetector(
                onTap: (() async {}),
                child: Text(' Đăng ký ngay',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange[900],
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    ),
  );
}

Widget renderHeader() {
  return Container(
    height: 100,
    alignment: Alignment.center,
    child: const Text(
      "Chào mừng đến với\n Smart Home",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 28, color: Colors.black, fontWeight: FontWeight.w700),
    ),
  );
}
