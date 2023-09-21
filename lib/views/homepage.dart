import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_app/components/custombutton.dart';
import 'package:firebase_app/views/notepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Note App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          actions: [
            IconButton(
                onPressed: () async {
                  try {
                    GoogleSignIn googleSignIn = GoogleSignIn();

                    await googleSignIn.disconnect();

                    await FirebaseAuth.instance.signOut();

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      'signin',
                      (route) => false,
                    );
                  } catch (e) {}
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: FirebaseAuth.instance.currentUser!.emailVerified
            ? NotePage()
            : Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    MaterialButton(
                      color: const Color.fromARGB(255, 236, 122, 114),
                      textColor: Colors.white,
                      height: 50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () {
                        FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: DialogType.noHeader,
                          desc: 'Check your Email adress',
                          descTextStyle: TextStyle(fontWeight: FontWeight.bold),
                        )..show();
                      },
                      child: Text(
                        'please verify your email adress',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
