import '../../../core/components/rest_client/rest_client.dart';

class ProfileDataSource {
  final RestClient _restClient;

  ProfileDataSource({required RestClient restClient})
      : _restClient = restClient;

  Future<void> changePassword(
      String currentPassword, String password, String confirmPassword) async {
    await _restClient.put(
      '/auth/change-password',
      body: {
        'currentPassword': currentPassword,
        'password': password,
        'confirmPassword': confirmPassword,
      },
    );
  }

  Future<void> changePhoneNumber(String phone) async {
    await _restClient.put('/auth/profile/edit', body: {'phone': phone});
  }

  Future<void> editProfile(String? fullName, String? phone) async {
    final Map<String, String> data = {};
    if (fullName != null) {
      data.addAll({'name': fullName});
    }
    if (phone != null) {
      data.addAll({'phone': phone});
    }
    await _restClient.put('/auth/profile/edit', body: data);
  }
}
