import 'package:mobx/mobx.dart';
part 'loginController.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  LoginController() {
    autorun((_) {
      print(email);
      print(password);
    });
  }

  @observable
  String email = '';
  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';
  @action
  void setPassword(String value) => password = value;
  @observable
  String confirmPassword = '';
  @action
  void setConfirmPassword(String value) => confirmPassword = value;

  @observable
  bool register = false;
  @action
  void setRegister() {
    register = !register;
  }

  @observable
  bool visibility = false;
  @action
  void setVisibility() {
    visibility = !visibility;
  }
}
