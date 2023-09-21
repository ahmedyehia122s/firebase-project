import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_app/Auth/signin.dart';
import 'package:firebase_app/components/custombutton.dart';
import 'package:firebase_app/components/customlogoauth.dart';
import 'package:firebase_app/components/customtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    TextEditingController Username = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    GlobalKey<FormState> formState = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: formState,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //logo
                    const CustomLogoAuth(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomField(
                      validator: (val) {
                        if (val == '') {
                          return 'Not Valid';
                        }
                        return null;
                      },
                      obscureText: false,
                      hinttext: 'Username',
                      myController: Username,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomField(
                      validator: (val) {
                        if (val == '') {
                          return 'Not Valid';
                        }
                        return null;
                      },
                      obscureText: false,
                      hinttext: 'Entre your email',
                      myController: email,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomField(
                      validator: (val) {
                        if (val == '') {
                          return 'Not Valid';
                        }
                        return null;
                      },
                      obscureText: true,
                      hinttext: 'Entre your password',
                      myController: password,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () {},
                            child: const Text('Forget password?'))),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Custombutton(
                  name: 'SignUp',
                  color: const Color.fromARGB(255, 236, 122, 114),
                  onpressed: () async {
                    if (formState.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();

                        Navigator.pushReplacementNamed(context, 'login');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          // print('The account already exists for that email.');

                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.error,
                            title: 'Error',
                            desc: 'The account already exists for that email.',
                          )..show();
                        } else if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.error,
                            title: 'Error',
                            desc: 'The password provided is too weak.',
                          )..show();
                        }
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      print('not valid');
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have an account?   ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'login');
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
