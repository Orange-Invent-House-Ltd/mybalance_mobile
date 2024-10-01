import 'package:flutter_riverpod/flutter_riverpod.dart';
import './extensions/string_extension.dart';

import 'logger.dart';

class AppProviderObserver extends ProviderObserver {
  const AppProviderObserver();

  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    logger.info(
      'Provider added: ${provider.name ?? provider.runtimeType}, value: $value',
    );
    super.didAddProvider(provider, value, container);
  }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    final buffer = StringBuffer()
      ..write('Provider: ${provider.name ?? provider.runtimeType} | ')
      ..writeln('Updated')
      ..write('Previous Value: ${previousValue.toString().limit(100)}')
      ..writeln(' => New Value: ${newValue.toString().limit(100)}');
    logger.info(buffer.toString());
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    logger.info(
      'Provider disposed: ${provider.name ?? provider.runtimeType}',
    );
    super.didDisposeProvider(provider, container);
  }

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    logger.error(
      'Provider: ${provider.name ?? provider.runtimeType} | $error',
      error: error,
      stackTrace: stackTrace,
    );
    super.providerDidFail(provider, error, stackTrace, container);
  }
}
