import 'package:chat_app/core/routing/app_router.dart';
import 'package:chat_app/features/login/logic/cubit/cubit/login_cubit.dart';
import 'package:chat_app/features/login/ui/login_page.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Chat(
    appRouter: AppRouter(),
  ));
}

class Chat extends StatelessWidget {
  const Chat({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        onGenerateRoute: appRouter.generateRoute,
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
