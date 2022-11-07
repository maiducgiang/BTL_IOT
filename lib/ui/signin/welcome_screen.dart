import 'package:auto_route/auto_route.dart';
import 'package:btliot/ui/LandingScreen/components/default_button.dart';
import 'package:btliot/ui/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widget/page_view_welcome.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF131A2D),
      resizeToAvoidBottomInset: true,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 170,
                    height: 170,
                    // decoration: const BoxDecoration(
                    //     //color: Colors.white,
                    //     image: DecorationImage(
                    //   image: AssetImage(
                    //     "assets/images/app/img_logo_app.png",
                    //   ),
                    //   fit: BoxFit.fill,
                    // )),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 400,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        PageViewWelcome(),
                      ],
                    ),
                  ),
                  DefaultButton(
                    size: size,
                    title: "Đăng nhập",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SigninScreen()),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
