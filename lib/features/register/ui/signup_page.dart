import 'package:chat_app/core/helper/constants.dart';
import 'package:chat_app/core/helper/show_snak_bar.dart';
import 'package:chat_app/core/widgets/custom_button.dart';
import 'package:chat_app/core/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email, password;
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 75),
                Image.asset(kLogo, height: 100),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Chat Duo',
                    style: TextStyle(
                        fontSize: 32,
                        color: kWhiteColor,
                        fontFamily: 'Pacifico'),
                  ),
                ),
                const SizedBox(height: 75),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Sign Up',
                          style: TextStyle(fontSize: 24, color: kWhiteColor)),
                      const SizedBox(height: 20),
                      CustomFormTextField(
                        onChanged: (data) => email = data,
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 10),
                      CustomFormTextField(
                        obscureText: true,
                        onChanged: (data) => password = data,
                        hintText: 'Password',
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() => isLoading = true);
                            try {
                              await registerUser();
                              showSnackBar(context, 'Success');
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                showSnackBar(context,
                                    "The password provided is too weak.");
                              } else if (e.code == 'email-already-in-use') {
                                showSnackBar(context,
                                    "The account already exists for that email.");
                              }
                            } catch (e) {
                              print(e);
                              showSnackBar(context, "There was an error.");
                            }
                            setState(() => isLoading = false);
                          }
                        },
                        text: 'REGISTER',
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?',
                              style: TextStyle(color: kWhiteColor)),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text('  Login',
                                style: TextStyle(color: kPurpleColor)),
                          ),
                        ],
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
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
