import 'package:firebase_app/Auth/signin.dart';
import 'package:firebase_app/Auth/signup.dart';
import 'package:firebase_app/views/homepage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(NoteApp());
}

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        color: const Color.fromARGB(255, 236, 122, 114),
      )),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified
          ? HomePage()
          : signin(),
      routes: {
        'signin': (context) => signin(),
        'signup': (context) => Signup(),
        'homepage': (context) => HomePage(),
      },
    );
  }
}
