import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/assetsPath.dart';
import '../utils/screen_background.dart';

class sphlashScreen extends StatefulWidget {
  static const String name = '/';
  const sphlashScreen({super.key});

  @override
  State<sphlashScreen> createState() => _sphlashScreenState();
}

class _sphlashScreenState extends State<sphlashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(
      context, SignInScreen.name

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Center(
        child: SvgPicture.asset(
          assetsPath.logoSvg
        ),
      ),),
    );
  }
}