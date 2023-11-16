import 'package:flutter/material.dart';
import 'package:notes/app/shared/utils/appRouter.dart';
import 'package:notes/app/views/homePage/homePage.dart';
import 'package:notes/app/views/pageLogin/pageLogin.dart';

class Notesapp extends StatelessWidget {
  const Notesapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      routes: {
        AppRoutes.AUTH_OR_HOME: (context) => const PageLogin(),
        AppRoutes.HOME: (context) => const HomePage()
      },
    );
  }
}
