import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

extension ProviderContext on BuildContext {
  ProviderContainer get _container {
    final providerScope = findAncestorWidgetOfExactType<ProviderScope>();
    if (providerScope == null) {
      throw StateError('No ProviderScope found in context');
    }
    return ProviderScope.containerOf(this);
  }

  T read<T>(ProviderListenable<T> provider) {
    return _container.read(provider);
  }
}
