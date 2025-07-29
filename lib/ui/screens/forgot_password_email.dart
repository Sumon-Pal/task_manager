import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/services/urls.dart';
import 'package:task_manager/ui/screens/pin_code_verification.dart';
import 'package:task_manager/ui/screens/sign_in_screen.dart';
import 'package:task_manager/ui/utils/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  static final String name = '/forgot-password-email';

  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final TextEditingController emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _getEmailAddressValidateInProgress = false;

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
                    'Your Email Address',
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
                  TextFormField(
                    controller: emailTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      String email = value ?? '';
                      if (EmailValidator.validate(email) == false) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  Visibility(
                    visible: _getEmailAddressValidateInProgress == false,
                    replacement: CircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(Icons.arrow_circle_right_outlined),
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
      _emailAddressValidate();
    }
  }

  void _onTapSignInButton() {
    Navigator.pushReplacementNamed(context, SignInScreen.name);
  }

  Future<void> _emailAddressValidate() async {
    _getEmailAddressValidateInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Url.getRecoveryVerifyEmailUrl(emailTEController.text.trim()),
    );
    if(response.isSuccess){
      if(mounted){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PinVerificationScreen(email: emailTEController.text.trim()),
          ),
        );
        // Navigator.pushReplacementNamed(context, PinVerificationScreen.name,arguments: emailTEController.text.trim());
        showSnackBarMessage(context, 'A 6 digit OTP code sent to your email');
        sendOtp();
      }
    }else{
      if(mounted){
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
    _getEmailAddressValidateInProgress = false;
    if(mounted){
      setState(() {});
    }
  }

  EmailAuth emailAuth = EmailAuth(sessionName: "Sample session");
  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: emailTEController.value.text, otpLength: 6
    );
  }

  @override
  void dispose() {
    emailTEController.dispose();
    super.dispose();
  }
}
