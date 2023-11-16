import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'connectionStore.g.dart';

class ConnectionStore = _ConnectionStoreBase with _$ConnectionStore;

abstract class _ConnectionStoreBase with Store {
  late StreamSubscription<InternetConnectionStatus> _connectionSubscription;

  late StreamController<bool> _connectionStatusController;

  _ConnectionStoreBase() {
    _connectionStatusController = StreamController<bool>();

    _connectionSubscription = InternetConnectionChecker().onStatusChange.listen(
      (status) {
        _connectionStatusController.add(
          status == InternetConnectionStatus.connected,
        );
      },
    );

    _connectionSubscription.onData(
      (status) {
        checkConnection();
      },
    );
  }

  @computed
  ConnectionStatus get connectionStatus {
    return isConnected
        ? ConnectionStatus.connected
        : ConnectionStatus.disconnected;
  }

  @observable
  bool isConnected = false;

  @action
  Future<void> _checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    isConnected = result;
  }

  @action
  Future<void> checkConnection() async {
    await _checkConnection();
  }

  void dispose() {
    _connectionSubscription.cancel();
    _connectionStatusController.close();
  }
}

enum ConnectionStatus {
  connected,
  disconnected,
}
