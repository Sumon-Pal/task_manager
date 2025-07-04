import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/forgot_password_email.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utils/screen_background.dart';

class SignInScreen extends StatefulWidget {
  static final String name = '/sign-in';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150,),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 42),
                  TextFormField(
                    controller: _emailTEcontroller,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value){
                      String email = value ?? '';
                      if(EmailValidator.validate(email)==false){
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _passwordTEcontroller,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value){
                      if((value?.length ?? 0)<=6){
                        return 'Enter a valid password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _onTapSignInButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _onTapForgotPasswordButton,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: 0.4,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                  letterSpacing: 0.4,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTapSignUpButton,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _onTapSignInButton() {
    if(_formKey.currentState!.validate()){
      //TODO: Sign in with API
    }
  }

  void _onTapForgotPasswordButton() {
    Navigator.pushReplacementNamed(context, ForgotPasswordEmailScreen.name);
  }

  void _onTapSignUpButton() {
    Navigator.pushReplacementNamed(context, SignUpScreen.name);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    super.dispose();
  }
}
