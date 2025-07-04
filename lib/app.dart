import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/screens/sphlash_screen.dart';

class task_manager extends StatelessWidget {
  const task_manager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 32,fontWeight:FontWeight.w900)
        ),
        inputDecorationTheme:
         InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w700
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none
        ),

      ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green
          )
        )
      ),
      initialRoute: '/',
      routes: {
        sphlashScreen.name : (context)=>sphlashScreen(),
        SignInScreen.name : (context)=> SignInScreen()
      },
    );
  }
}
