import './data_source.dart';

class ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepository({required ProfileDataSource dataSource})
      : _dataSource = dataSource;

  Future<void> changePassword(
    String currentPassword,
    String password,
    String confirmPassword,
  ) async {
    await _dataSource.changePassword(
      currentPassword,
      password,
      confirmPassword,
    );
  }

  Future<void> changePhoneNumber(String phone) async {
    await _dataSource.changePhoneNumber(phone);
  }

  Future<void> editProfile(String? fullName, String? phone) async {
    await _dataSource.editProfile(fullName, phone);
  }
}
