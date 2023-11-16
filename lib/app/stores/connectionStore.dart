import 'package:mobx/mobx.dart';
part 'connectionstore.g.dart';

class ConnectionStore = _ConnectionStoreBase with _$ConnectionStore;

abstract class _ConnectionStoreBase with Store {
  @observable
  bool isConnected = false;
}
