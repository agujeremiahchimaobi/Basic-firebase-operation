import 'package:firebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome'),
            Text(
              user.email!,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await auth.signOut();
                if (!mounted) return;
                Navigator.pop(context);
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
