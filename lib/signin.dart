import 'package:email_validator/email_validator.dart';
import 'package:firebase/homepage.dart';
import 'package:firebase/resetpassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignIn extends StatefulWidget {
  static String id = 'SignUp';
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signIn() async {
    final isvalid = formkey.currentState!.validate();
    if (!isvalid) return;

    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      if (!mounted) return;
      Navigator.pushNamed(context, HomePage.id);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
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
                        ? 'Please Enter a valid email'
                        : null,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'password'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => password != null && password.length < 6
                    ? 'password must be at least 6 characters'
                    : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  signIn();
                },
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, ResetPassword.id),
                child: const Text('Forgot Password'),
              ),
              const SizedBox(height: 20),
              Text('Sign Un')
            ],
          ),
        ),
      ),
    );
  }
}
