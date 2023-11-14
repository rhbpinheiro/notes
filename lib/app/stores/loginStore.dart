import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:notes/app/shared/helpers/messages.dart';
import 'package:notes/app/shared/utils/appRouter.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'loginStore.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  _LoginStoreBase() {
    getPrefsLogin();
  }
  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';

  @action
  void setPassword(String value) => password = value;

  @action
  Future<void> getPrefsLogin() async {
    await prefs.then((value) {
      email = value.getString('email') ?? "";
      password = value.getString('password') ?? "";
    });
  }

  @action
  Future<void> savePrefsLogin(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  @observable
  bool visibilityPassword = false;

  @action
  void setVisibilityPassword() {
    visibilityPassword = !visibilityPassword;
  }

  @observable
  bool loagind = false;

  @action
  void setLoading() {
    loagind = !loagind;
  }

  @action
  bool validate(BuildContext context) {
    final RegExp specialChars = RegExp(r'[!@#%^&*()]');
    final RegExp emailValid =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailValid.hasMatch(email)) {
      Messages(context).showError('Digite um email válido.');
      return false;
    }
    if (email.length > 20 || password.length > 20) {
      Messages(context).showError(
          'Os campos Usuário e Senha devem conter no máximo 20 caracteres.');
      return false;
    }
    if (email.isEmpty) {
      Messages(context).showError('O campo Usuário é obrigatorio.');
      return false;
    }
    if (email.endsWith(' ')) {
      Messages(context)
          .showError('O campo Usuário não pode terminar com espaço.');
      return false;
    }
    if (email.endsWith(' ')) {
      Messages(context)
          .showError('O campo Usuário não pode terminar com espaço.');
      return false;
    }
    if (password.endsWith(' ')) {
      Messages(context)
          .showError('O campo Senha não pode terminar com espaço.');
      return false;
    }
    if (password.isEmpty) {
      Messages(context).showError('O campo Senha é obrigatorio.');
      return false;
    }
    if (password.length <= 2) {
      Messages(context)
          .showError('O campo Senha deve conter mais de 2 caracteres.');
      return false;
    }
    if (specialChars.hasMatch(password)) {
      Messages(context)
          .showError('O campo Senha não pode ter caracteres especiais.');
      return false;
    }
    return true;
  }

  @action
  signIn(BuildContext context) async {
    if (validate(context)) {
      setLoading();
      savePrefsLogin(email, password);
      await Future.delayed(const Duration(seconds: 2));
      Messages(context).showSuccess('Login efetuado com sucesso.');
      setLoading();
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
    }
  }
}
