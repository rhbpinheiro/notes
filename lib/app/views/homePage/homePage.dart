import 'package:flutter/material.dart';
import 'package:notes/app/shared/constants.dart';
import 'package:notes/app/shared/helpers/size_extensions.dart';
import 'package:notes/app/shared/widgets/WidgetButton.dart';
import 'package:notes/app/shared/widgets/WidgetTextFormField.dart';

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
            Container(
              width: context.screenWidth * .8,
              height: context.screenHeight * .4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            const WidgetTextFormField(
              title: '',
              obscureText: false,
              autofocus: false,
              suffixIcon: Icon(Icons.add),
              prefixIcon: SizedBox.shrink(),
              hintText: 'Digite seu texto',
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
