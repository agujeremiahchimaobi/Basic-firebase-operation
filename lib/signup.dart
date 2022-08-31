import 'package:email_validator/email_validator.dart';
import 'package:firebase/emailverification.dart';
import 'package:firebase/homepage.dart';
import 'package:firebase/main.dart';
import 'package:firebase/resetpassword.dart';
import 'package:firebase/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  static String id = 'SignUpScreen';
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() async {
    final isvalid = formkey.currentState!.validate();
    if (!isvalid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await _auth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verification message sent successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamed(context, EmailVerification.id);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!), backgroundColor: Colors.red),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid Email'
                        : null,
              ),
              const SizedBox(height: 30),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'password'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  _register();
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, SignIn.id),
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
