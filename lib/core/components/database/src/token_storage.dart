import 'dart:async';

import '../../rest_client/rest_client.dart';
import './preference_entry.dart';
import './storage_manager.dart';
import './storage_provider/storage_provider.dart';

final class TokenStorage implements StorageManager<Token> {
  TokenStorage({required StorageProvider storageProvider})
      : _accessToken = TypedEntry(
          storageProvider: storageProvider,
          key: 'authorization.access_token',
        ),
        _refreshToken = TypedEntry(
          storageProvider: storageProvider,
          key: 'authorization.refresh_token',
        ) {
    getStream().listen((token) {
      _cachedToken = token;
    });
  }

  late final PreferencesEntry<String> _accessToken;
  late final PreferencesEntry<String> _refreshToken;
  final _streamController = StreamController<Token?>.broadcast();
  Token? _cachedToken;

  @override
  Future<Token?> load() async {
    final accessToken = _accessToken.read();
    final refreshToken = _refreshToken.read();

    return Future.wait([accessToken, refreshToken]).then((values) {
      final accessToken = values[0];
      final refreshToken = values[1];

      if (accessToken == null || refreshToken == null) return null;
      final token = Token(accessToken, refreshToken);
      _cachedToken = token;
      return token;
    });
  }

  @override
  Future<void> save(Token tokenPair) async {
    (
      _accessToken.set(tokenPair.accessToken),
      _refreshToken.set(tokenPair.refreshToken)
    ).wait;

    _cachedToken = tokenPair;
    _streamController.add(tokenPair);
  }

  @override
  Stream<Token?> getStream() => _streamController.stream;

  @override
  Future<void> clear() async {
    await (_accessToken.remove(), _refreshToken.remove()).wait;
    _cachedToken = null;
    _streamController.add(null);
  }

  @override
  Future<void> close() => _streamController.close();

  Token? get cachedToken => _cachedToken;
}
