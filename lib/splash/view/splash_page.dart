import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Home.dart';
import '../../login/view/login_form.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // static Route<void> route() {
  @override
  void initState() {
    next();
    super.initState();
  }

  next() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) async {
      var sharedPrefs = await SharedPreferences.getInstance();
      var isLoggedIng = sharedPrefs.getString('token');
      // await _sharedPrefs.getString('token');
      if (isLoggedIng != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const Home();
        }));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
          child: CircularProgressIndicator(
        color: Colors.amber,
      )),
    );
  }
}
