import 'dart:convert';

class JWT {
  JWT(this.token) {
    _parts = token.split('.');
    if (_parts.length != 3) {
      throw const FormatException('Invalid token');
    }
  }
  final String token;
  late List<String> _parts;

  Map<String, dynamic> decode() {
    try {
      final payloadBase64 = _parts[1];
      final normalized = base64Url.normalize(payloadBase64);
      final payloadString = utf8.decode(base64Url.decode(normalized));
      return jsonDecode(payloadString);
    } catch (e) {
      throw const FormatException('Invalid token');
    }
  }

  Map<String, dynamic>? tryDecode() {
    try {
      return decode();
    } catch (error) {
      return null;
    }
  }

  bool isExpired() {
    final expirationDate = getExpirationDate();
    if (expirationDate == null) {
      return false;
    }
    return DateTime.now().isAfter(expirationDate);
  }

  DateTime? _getDate({required String claim}) {
    final decodedToken = decode();
    final expiration = decodedToken[claim] as int?;
    if (expiration == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(expiration * 1000);
  }

  DateTime? getExpirationDate() {
    return _getDate(claim: 'exp');
  }

  DateTime? getIssuedAtDate() {
    return _getDate(claim: 'iat');
  }

  Duration? getTokenTime() {
    final issuedAtDate = getIssuedAtDate();
    if (issuedAtDate == null) {
      return null;
    }
    return DateTime.now().difference(issuedAtDate);
  }

  Duration? getRemainingTime() {
    final expirationDate = getExpirationDate();
    if (expirationDate == null) {
      return null;
    }

    return expirationDate.difference(DateTime.now());
  }
}
