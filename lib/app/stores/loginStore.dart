import 'package:mobx/mobx.dart';
part 'loginStore.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';

  @action
  void setPassword(String value) => password = value;

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
}
