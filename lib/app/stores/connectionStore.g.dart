// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectionStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConnectionStore on _ConnectionStoreBase, Store {
  Computed<ConnectionStatus>? _$connectionStatusComputed;

  @override
  ConnectionStatus get connectionStatus => (_$connectionStatusComputed ??=
          Computed<ConnectionStatus>(() => super.connectionStatus,
              name: '_ConnectionStoreBase.connectionStatus'))
      .value;

  late final _$isConnectedAtom =
      Atom(name: '_ConnectionStoreBase.isConnected', context: context);

  @override
  bool get isConnected {
    _$isConnectedAtom.reportRead();
    return super.isConnected;
  }

  @override
  set isConnected(bool value) {
    _$isConnectedAtom.reportWrite(value, super.isConnected, () {
      super.isConnected = value;
    });
  }

  late final _$_checkConnectionAsyncAction =
      AsyncAction('_ConnectionStoreBase._checkConnection', context: context);

  @override
  Future<void> _checkConnection() {
    return _$_checkConnectionAsyncAction.run(() => super._checkConnection());
  }

  late final _$checkConnectionAsyncAction =
      AsyncAction('_ConnectionStoreBase.checkConnection', context: context);

  @override
  Future<void> checkConnection() {
    return _$checkConnectionAsyncAction.run(() => super.checkConnection());
  }

  @override
  String toString() {
    return '''
isConnected: ${isConnected},
connectionStatus: ${connectionStatus}
    ''';
  }
}
