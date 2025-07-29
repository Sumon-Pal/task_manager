import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/data/services/urls.dart';
import 'package:task_manager/ui/screens/set_password.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/screen_background.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';

import '../../data/services/network_caller.dart';
import '../widgets/snack_bar_message.dart';

class PinVerificationScreen extends StatefulWidget {
  //static final String name = '/pin-verification';
  final String email;

  const PinVerificationScreen({super.key, required this.email});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _getVerifyOtpInProgress = false;


  @override
  Widget build(BuildContext context) {
    //final String _email = ModalRoute.of(context)!.settings.arguments as String;
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
                    'PIN Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'A 6 digit verification pin will send to your email address',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 28),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.grey,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    controller: _otpTEController,
                    onCompleted: (v) {
                     // print("Completed");
                    },
                    appContext: context,
                  ),

                  const SizedBox(height: 16),
                  Visibility(
                    visible: _getVerifyOtpInProgress == false,
                    replacement: CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Text('Verify'),
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

  void _onTapSubmitButton() {
    if(_formKey.currentState!.validate()){
      _otpVerify();
    }
  }

  void _onTapSignInButton() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  // EmailAuth emailAuth = EmailAuth(sessionName: "Sample session");
  // bool verifyOtp() {
  //   return emailAuth.validateOtp(
  //     recipientMail:widget.email,
  //     userOtp: _otpTEController.text.trim(),
  //   );
  // }

  Future<void> _otpVerify() async {
    _getVerifyOtpInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(
      url:Url.getVerifyOtpUrl(widget.email, _otpTEController.text),
    );
    if(response.isSuccess){
      if(mounted){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetPassword(email:widget.email, otp:_otpTEController.text,),
          ),
        );
        showSnackBarMessage(context, 'OTP Verification Successful');
      }
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
    _getVerifyOtpInProgress = false;
    if(mounted){
      setState(() {});
    }
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
