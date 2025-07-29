import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/services/urls.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/screen_background.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';

import '../../data/services/network_caller.dart';
import '../widgets/snack_bar_message.dart';

class SetPassword extends StatefulWidget {
  //static final String name = '/set-password';
  final String email,otp;

  const SetPassword({super.key, required this.email, required this.otp});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _getSetPasswordInProgress = false;

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
                  const SizedBox(height: 150),
                  Text(
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Minimum length password 8 Character with\n latter and number combination',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 28),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if ((value?.length ?? 0) <= 7) {
                        return 'Enter a valid password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(hintText: 'Confirm Password'),
                    validator: (String? value) {
                      if ((value ?? '') != _passwordTEController.text) {
                        return 'Confirm Password not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: _getSetPasswordInProgress ==false,
                    replacement: CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapConfirmButton,
                      child: Text('Confirm'),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 0.4,
                        ),
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                              letterSpacing: 0.4,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
                          ),
                        ],
                      ),
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

  void _onTapConfirmButton() {
    _setPassword();
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  void _onTapSignInButton() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  Future<void> _setPassword() async {
    _getSetPasswordInProgress = true;
    if(mounted){
      setState(() {});
    }
    Map<String, String> requestBody={
      "email":widget.email,
      "OTP": widget.otp,
      "password":_passwordTEController.text
    };

    NetworkResponse response = await NetworkCaller.postRequest(url:Url.setPasswordUrl,body: requestBody);
    _getSetPasswordInProgress = false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){
      _passwordTEController.clear();
      if(mounted){
        showSnackBarMessage(context, 'Password Updated');
      }
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage!);
      }
    }

  }

  @override
  void dispose() {
    _confirmPasswordTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
