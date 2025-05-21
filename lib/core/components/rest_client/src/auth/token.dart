class Token {
  /// Create a [Token]
  const Token(this.accessToken, this.refreshToken);

  /// Access token (used to authenticate the user)
  final String accessToken;

  /// Refresh token (used to refresh the access token)
  final String refreshToken;

  @override
  String toString() =>
      'Token(accessToken: $accessToken, refreshToken: $refreshToken)';
}
