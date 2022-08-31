import 'package:firebase/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class OtpVerification extends StatefulWidget {
  static String id = 'OtpVerification';
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  String verificationidRecieved = '';

  bool isvisibile = false;

  Future<void> fetchOtp() async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('e.message!')));
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message!)));
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationidRecieved = verificationId;
          isvisibile = true;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String veriificationId) {});
  }

  Future<void> verify() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: phoneNumberController,
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: isvisibile,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: otpController,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  fetchOtp();
                },
                child: Text(isvisibile ? 'Verify' : 'Fetch Otp'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
