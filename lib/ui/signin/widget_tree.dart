import 'package:btliot/data/cache_manager.dart';
import 'package:btliot/data/model/user_local/user_model_local.dart';
import 'package:btliot/ui/auth.dart';
import 'package:btliot/ui/signin/signin_screen.dart';
import 'package:btliot/ui/signin/widget/forgot_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  final CacheManager _cacheManager = CacheManager.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        // print(snapshot.data?.uid.toString());
        print(snapshot);
        var data = snapshot.data;
        if (snapshot.hasData) {
          _cacheManager
              .addUserToCached(UserLocal(name: data!.email ?? "", phone: ""));
          return const ForgotPasswordScreen();
        } else {
          return const SigninScreen();
        }
      },
    );
  }
}
