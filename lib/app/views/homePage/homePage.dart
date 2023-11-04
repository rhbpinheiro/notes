import 'package:flutter/material.dart';
import 'package:notes/app/shared/constants.dart';
import 'package:notes/app/shared/widgets/WidgetButton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1f5466),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: gradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            WidgetButton(
              width: 150,
              height: 40,
              title: 'Entar',
              background: const Color(0xff44bd6e),
              titleColor: Colors.white,
              voidFunction: () {},
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: const Text(
                'Política de Privacidade',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
