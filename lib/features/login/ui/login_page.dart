import 'package:chat_app/core/helper/constants.dart';
import 'package:chat_app/core/helper/extension.dart';
import 'package:chat_app/core/helper/show_snak_bar.dart';
import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/core/widgets/custom_button.dart';
import 'package:chat_app/core/widgets/custom_text_field.dart';
import 'package:chat_app/features/login/logic/cubit/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          context.pushNamed(Routes.chatPage);
          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMsg);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
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
                        const Text('Log In',
                            style: TextStyle(fontSize: 24, color: kWhiteColor)),
                        const SizedBox(height: 20),
                        CustomFormTextField(
                          color: kWhiteColor,
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
                              BlocProvider.of<LoginCubit>(context).loginUser(
                                  email: email!, password: password!);
                              await secureStorage.write(
                                  key: 'email', value: email!);
                            }
                          },
                          text: 'LOGIN',
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?',
                                style: TextStyle(color: kWhiteColor)),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, Routes.registerPage),
                              child: const Text('  Register',
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
      ),
    );
  }
}
