import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:notes/app/shared/constants.dart';
import 'package:notes/app/shared/helpers/size_extensions.dart';
import 'package:notes/app/shared/widgets/WidgetButton.dart';
import 'package:notes/app/shared/widgets/WidgetTextFormField.dart';
import 'package:notes/app/stores/loginStore.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anotações',
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
                        Observer(
                          builder: (_) {
                            return WidgetTextFormField(
                              title: 'Usuário',
                              controller: emailController,
                              hintText: loginStore.email.isEmpty
                                  ? 'Email'
                                  : loginStore.email,
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.start,
                              prefixIcon: const Icon(Icons.person),
                              onChanged: loginStore.setEmail,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Observer(
                          builder: (_) {
                            return WidgetTextFormField(
                              title: 'Senha',
                              controller: passwordController,
                              obscureText: !loginStore.visibilityPassword,
                              hintText: loginStore.password.isEmpty
                                  ? 'Senha'
                                  : loginStore.password,
                              onChanged: loginStore.setPassword,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: InkWell(
                                onTap: loginStore.setVisibilityPassword,
                                child: Icon(loginStore.visibilityPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Observer(builder: (_) {
                              return WidgetButton(
                                  width: 150,
                                  height: 40,
                                  title: 'Entar',
                                  background: const Color(0xff44bd6e),
                                  titleColor: Colors.white,
                                  function: () async {
                                    loginStore.signIn(context);
                                  });
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
                          onTap: () {
                            final Uri url =
                                Uri.parse("https://www.google.com.br");
                            launchUrl(url);
                          },
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
}
