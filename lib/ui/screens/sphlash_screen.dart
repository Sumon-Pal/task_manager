import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/screens/controlers/auth_controler.dart';
import 'package:task_manager/ui/screens/main_nav_bar_holder_screen.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/assets_path.dart';
import '../utils/screen_background.dart';

class SphlashScreen extends StatefulWidget {
  static const String name = '/';

  const SphlashScreen({super.key});

  @override
  State<SphlashScreen> createState() => _SphlashScreenState();
}

class _SphlashScreenState extends State<SphlashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    //
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));
    bool isLoggedIn = await AuthController.isUserLoggedIn();
    if(isLoggedIn){
      Navigator.pushReplacementNamed(context, MainNavBarHolderScreen.name);
    }else{
      Navigator.pushNamedAndRemoveUntil (
        context,
        SignInScreen.name,
            (predicate) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(child: SvgPicture.asset(AssetsPath.logoSvg)),
      ),
    );
  }
}
