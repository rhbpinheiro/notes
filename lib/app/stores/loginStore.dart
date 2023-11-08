import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'loginStore.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
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
}
