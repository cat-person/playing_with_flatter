import 'package:flutter/material.dart';
import 'package:snd/vm/base/vm.dart';

abstract class MyPage<TState>
    extends StreamBuilderBase<TState, AsyncSnapshot<TState>> {
  final TState initialData;
  final bool Function(VMEvent event) eventHandler;

  const MyPage({
    super.key,
    required super.stream,
    required this.initialData,
    required this.eventHandler,
  });

  @override
  AsyncSnapshot<TState> initial() => initialData == null
      ? AsyncSnapshot<TState>.nothing()
      : AsyncSnapshot<TState>.withData(ConnectionState.none, initialData);

  @override
  AsyncSnapshot<TState> afterConnected(AsyncSnapshot<TState> current) =>
      current.inState(ConnectionState.waiting);

  @override
  AsyncSnapshot<TState> afterData(AsyncSnapshot<TState> current, TState data) {
    return AsyncSnapshot<TState>.withData(ConnectionState.active, data);
  }

  @override
  AsyncSnapshot<TState> afterError(
    AsyncSnapshot<TState> current,
    Object error,
    StackTrace stackTrace,
  ) {
    return AsyncSnapshot<TState>.withError(
      ConnectionState.active,
      error,
      stackTrace,
    );
  }

  @override
  AsyncSnapshot<TState> afterDone(AsyncSnapshot<TState> current) =>
      current.inState(ConnectionState.done);

  @override
  AsyncSnapshot<TState> afterDisconnected(AsyncSnapshot<TState> current) =>
      current.inState(ConnectionState.none);
}
