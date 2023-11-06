import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:notes/app/controllers/loginController.dart';
import 'package:notes/app/shared/constants.dart';
import 'package:notes/app/shared/helpers/messages.dart';
import 'package:notes/app/shared/helpers/size_extensions.dart';
import 'package:notes/app/shared/utils/appRouter.dart';
import 'package:notes/app/shared/widgets/WidgetButton.dart';
import 'package:notes/app/shared/widgets/WidgetTextFormField.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  TextEditingController tedUser = TextEditingController();
  TextEditingController tedPassword = TextEditingController();
  TextEditingController tedConfirmPassword = TextEditingController();
  LoginController loginController = LoginController();
  bool register = false;
  @override
  Widget build(BuildContext context) {
    print(loginController.email);
    print(loginController.password);
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.screenHeight * .2,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  !register ? 'Login' : 'Cadastre-se',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ]),
              const SizedBox(
                height: 40,
              ),
              WidgetTextFormField(
                hintText: 'Email',
                title: 'Usuário',
                obscureText: false,
                autofocus: false,
                prefixIcon: const Icon(Icons.person),
                onChanged: loginController.setEmail,
              ),
              const SizedBox(
                height: 30,
              ),
              WidgetTextFormField(
                hintText: 'Senha',
                title: 'Senha',
                obscureText: true,
                autofocus: false,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility),
                onChanged: loginController.setPassword,
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 500),
                child: register
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          WidgetTextFormField(
                            hintText: 'Confirm a Senha',
                            title: 'Confirme a Senha',
                            obscureText: true,
                            autofocus: false,
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: Icon(Icons.visibility),
                            onChanged: loginController.setConfirmPassword,
                          ),
                        ],
                      )
                    : Container(),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  WidgetButton(
                    width: 150,
                    height: 40,
                    title: register ? 'Cadastre-se' : 'Entar',
                    background: const Color(0xff44bd6e),
                    titleColor: Colors.white,
                    voidFunction: () {
                      if (!register) {
                        _signIn();
                      } else {
                        _register();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Não tem conta? ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            register = !register;
                          });
                        },
                        child: Text(
                          'Cadastre-se',
                          style: TextStyle(
                            color: Colors.brown.shade900,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.brown.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: context.screenHeight * .2,
              ),
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
      ),
    );
  }

  bool _validate() {
    final RegExp specialChars = RegExp(r'[!@#%^&*()]');
    if (loginController.email.length > 20 ||
        loginController.password.length > 20) {
      Messages(context).showError(
          'Os campos Usuário e Senha devem conter no máximo 20 caracteres.');
      return false;
    }
    if (loginController.email.isEmpty) {
      Messages(context).showError('O campo Usuário é obrigatorio.');
      return false;
    }
    if (loginController.email.endsWith(' ')) {
      Messages(context)
          .showError('O campo Usuário não pode terminar com espaço.');
      return false;
    }
    if (loginController.password.endsWith(' ')) {
      Messages(context)
          .showError('O campo Senha não pode terminar com espaço.');
      return false;
    }
    if (loginController.password.isEmpty) {
      Messages(context).showError('O campo Senha é obrigatorio.');
      return false;
    }
    if (loginController.password.length <= 2) {
      Messages(context)
          .showError('O campo Senha deve conter mais de 2 caracteres.');
      return false;
    }
    if (specialChars.hasMatch(loginController.password)) {
      Messages(context)
          .showError('O campo Senha não pode ter caracteres especiais.');
      return false;
    }
    if (register) {
      if (loginController.password != loginController.confirmPassword) {
        Messages(context)
            .showError('Os campo Senha e Confirme a Senha dever ser iguais.');
        return false;
      }
    }
    return true;
  }

  void _signIn() {
    if (_validate()) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
    }
  }

  void _register() {
    if (_validate()) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
    }
  }
}
