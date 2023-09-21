import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_app/Auth/signup.dart';
import 'package:firebase_app/components/custombutton.dart';
import 'package:firebase_app/components/customlogoauth.dart';
import 'package:firebase_app/components/customtextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushNamedAndRemoveUntil(context, 'homepage', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Scaffold(
        body: SafeArea(
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
                          return 'Empty';
                        }
                        if (!val!.contains('@')) {
                          return 'Not Valid @ requried';
                        }
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
                      },
                      obscureText: true,
                      hinttext: 'Entre your password',
                      myController: password,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () async {
                            if (email.text == '') {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.error,
                                title: 'Error',
                                desc: 'Please write your email adress',
                              )..show();
                              return;
                            }
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email.text);
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.success,
                                title: 'sucess',
                                desc: 'Check your Email',
                              )..show();
                            } catch (e) {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.error,
                                title: 'error',
                                desc: 'please write correct email',
                              )..show();
                            }
                          },
                          child: const Text('Forget password?'),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Custombutton(
                  name: 'Sign in',
                  color: const Color.fromARGB(255, 236, 122, 114),
                  onpressed: () async {
                    if (formState.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        Navigator.pushReplacementNamed(context, 'homepage');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.error,
                            title: 'Error',
                            desc: 'No user found for that email.',
                          )..show();
                        } else if (e.code == 'wrong-password') {
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.error,
                            title: 'Error',
                            desc: 'Wrong password provided for that user',
                          )..show();
                        }
                      }
                    } else {
                      print('not Valid');
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Or Login With',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    height: 50,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      signInWithGoogle();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sign in With Google',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'images/google.png',
                          width: 40,
                        )
                      ],
                    )),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Do not have an account?   ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'signup');
                      },
                      child: const Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
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
