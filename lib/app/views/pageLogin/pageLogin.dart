import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:notes/app/shared/constants.dart';
import 'package:notes/app/shared/helpers/messages.dart';
import 'package:notes/app/shared/helpers/size_extensions.dart';
import 'package:notes/app/shared/utils/appRouter.dart';
import 'package:notes/app/shared/widgets/WidgetButton.dart';
import 'package:notes/app/shared/widgets/WidgetTextFormField.dart';
import 'package:notes/app/stores/loginStore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginStore loginStore = LoginStore();

  @override
  void initState() {
    super.initState();
    loginStore.getPrefsLogin();
  }

  @override
  Widget build(BuildContext context) {
    print(loginStore.email);
    print(loginStore.password);

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
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: gradient,
        ),
        child: Observer(
          builder: (_) {
            return SingleChildScrollView(
              child: loginStore.loagind
                  ? LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.white,
                      size: 60,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: context.screenHeight * .2,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Observer(builder: (_) {
                          return WidgetTextFormField(
                            hintText: 'Email',
                            title: 'Usuário',
                            readOnly: false,
                            obscureText: false,
                            controller: emailController,
                            autofocus: false,
                            prefixIcon: const Icon(Icons.person),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: loginStore.setEmail,
                          );
                        }),
                        const SizedBox(
                          height: 30,
                        ),
                        Observer(builder: (_) {
                          return WidgetTextFormField(
                            keyboardType: TextInputType.text,
                            hintText: 'Senha',
                            title: 'Senha',
                            readOnly: false,
                            controller: passwordController,
                            obscureText: !loginStore.visibilityPassword,
                            autofocus: false,
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: InkWell(
                              onTap: loginStore.setVisibilityPassword,
                              child: Icon(loginStore.visibilityPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            onChanged: loginStore.setPassword,
                          );
                        }),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            WidgetButton(
                                width: 150,
                                height: 40,
                                title: 'Entar',
                                background: const Color(0xff44bd6e),
                                titleColor: Colors.white,
                                function: () {
                                  _signIn();
                                }),
                            const SizedBox(
                              height: 20,
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
            );
          },
        ),
      ),
    );
  }

  bool _validate() {
    final RegExp specialChars = RegExp(r'[!@#%^&*()]');
    final RegExp emailValid =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailValid.hasMatch(loginStore.email)) {
      Messages(context).showError('Digite um email válido.');
      return false;
    }
    if (loginStore.email.length > 20 || loginStore.password.length > 20) {
      Messages(context).showError(
          'Os campos Usuário e Senha devem conter no máximo 20 caracteres.');
      return false;
    }
    if (loginStore.email.isEmpty) {
      Messages(context).showError('O campo Usuário é obrigatorio.');
      return false;
    }
    if (loginStore.email.endsWith(' ')) {
      Messages(context)
          .showError('O campo Usuário não pode terminar com espaço.');
      return false;
    }
    if (loginStore.email.endsWith(' ')) {
      Messages(context)
          .showError('O campo Usuário não pode terminar com espaço.');
      return false;
    }
    if (loginStore.password.endsWith(' ')) {
      Messages(context)
          .showError('O campo Senha não pode terminar com espaço.');
      return false;
    }
    if (loginStore.password.isEmpty) {
      Messages(context).showError('O campo Senha é obrigatorio.');
      return false;
    }
    if (loginStore.password.length <= 2) {
      Messages(context)
          .showError('O campo Senha deve conter mais de 2 caracteres.');
      return false;
    }
    if (specialChars.hasMatch(loginStore.password)) {
      Messages(context)
          .showError('O campo Senha não pode ter caracteres especiais.');
      return false;
    }
    return true;
  }

  void _signIn() async {
    if (_validate()) {
      loginStore.setLoading();
      loginStore.savePrefsLogin(loginStore.email, loginStore.password);
      await Future.delayed(Duration(seconds: 2));
      Messages(context).showSuccess('Login efetuado com sucesso.');
      loginStore.setLoading();
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
    }
  }
}
