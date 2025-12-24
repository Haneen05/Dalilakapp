import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daleelakappx/screens/account/login/otp_input.dart';
import 'package:daleelakappx/screens/screen_background.dart';
import 'package:daleelakappx/theme.dart';
import 'package:daleelakappx/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget implements ScreenBackground {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  @override
  Color bgColor() => Colors.white;
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  String phoneNumber = '';
  String inputOtp = '';
  bool requestedOtp = false;
  String? verificationId;
  String? error;
  var otpWidgetKey = GlobalKey<OtpInputWidgetState>();

  @override
  Widget build(BuildContext context) {
    final error = this.error;
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 62.0, 20.0, 30.0),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  TopBarWidget(
                      title: Text(AppLocalizations.of(context)!.login)),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DColumn(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSpacing: DBox.mdSpace,
                            children: [
                              const Text(
                                'Enter Your Phone Number',
                                style: TextStyle(
                                  color: Color(0xff64748b),
                                  fontSize: DBox.fontLg,
                                ),
                              ),
                              const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: 'We will Send you the'),
                                    TextSpan(
                                      text: ' 6 digits ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(text: 'verification code'),
                                  ],
                                  style: TextStyle(color: Color(0xff1a0429)),
                                ),
                              ),
                              if (requestedOtp)
                                OtpInputWidget(
                                  key: otpWidgetKey,
                                  constraints: constraints,
                                  onFilled: (otp) {
                                    setState(() => inputOtp = otp);
                                  },
                                  otpLength: 6,
                                ),
                              if (!requestedOtp)
                                TextField(
                                  onChanged: (text) {
                                    setState(() => phoneNumber = text);
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter Mobile Number',
                                  ),
                                ),
                              if (error != null)
                                SelectableText(
                                  error,
                                  maxLines: 2,
                                  style:
                                      const TextStyle(color: Color(0xffe16060)),
                                ),
                            ],
                          ),
                        ),
                        if (loading)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        if (!loading)
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 260.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (requestedOtp)
                                  DButton.elevated(
                                    onPressed: verify,
                                    backgroundColor: const Color(0xfff9da42),
                                    child: const Text('Verify'),
                                  ),
                                if (requestedOtp)
                                  DButton.outlined(
                                    onPressed: generateOTP,
                                    foregroundColor: const Color(0xff94a3b8),
                                    borderColor: const Color(0xff94a3b8),
                                    child: const Text('SendAgain'),
                                  ),
                                if (!requestedOtp)
                                  DButton.elevated(
                                    onPressed: generateOTP,
                                    backgroundColor: const Color(0xfff9da42),
                                    child: const Text('GenerateOTP'),
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
      );
    });
  }

  Future<void> generateOTP() async {
    setState(() {
      loading = true;
      error = null;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
          User? user = userCredential.user;

          if (user != null) {
            DocumentSnapshot userDoc = await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

            if (!userDoc.exists) {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .set({
                'phoneNumber': user.phoneNumber,
                'createdAt': FieldValue.serverTimestamp(),
              });
              print('Auto verified: created');
            } else {
              print('Auto verified: exists');
            }
          }
        } catch (e) {
          print('Auto verification error: $e');
        } finally {
          setState(() => loading = false);
        }
      },
      verificationFailed: (FirebaseAuthException error) {
        setState(() {
          this.error = 'Verification failed: ${error.message}';
          loading = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          this.verificationId = verificationId;
          loading = false;
          requestedOtp = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          loading = false;
          error = 'Timed out';
        });
      },
    );
  }

  void verify() async {
    setState(() {
      loading = true;
      error = null;
    });
    final navigator = Navigator.of(context);
    final verificationId = this.verificationId;
    if (verificationId != null) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: inputOtp);

      // Sign the user in (or link) with the credential
      try {
        await FirebaseAuth.instance.signInWithCredential(credential);

        navigator.popUntil((route) => route.isFirst);
      } catch (error) {
        if (error.toString().contains("PigeonUserDetails")) {
          navigator.popUntil((route) => route.isFirst);
        } else {
          setState(() => this.error = 'Login failed, please try again');
        }
      } finally {
        setState(() => loading = false);
      }
    }
  }
}
