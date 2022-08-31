import 'package:firebase/emailverification.dart';
import 'package:firebase/homepage.dart';
import 'package:firebase/otppage.dart';
import 'package:firebase/resetpassword.dart';
import 'package:firebase/signin.dart';
import 'package:firebase/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorkey,
      initialRoute: OtpVerification.id,
      routes: {
        SignUp.id: (context) => const SignUp(),
        HomePage.id: (context) => const HomePage(),
        SignIn.id: (context) => const SignIn(),
        ResetPassword.id: (context) => const ResetPassword(),
        EmailVerification.id: (context) => const EmailVerification(),
        OtpVerification.id: (context) => const OtpVerification(),
      },
    );
  }
}
