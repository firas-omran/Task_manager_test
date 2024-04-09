import '../../data/api/auth_data_provider.dart';

class AuthRepository {
  final AuthDataProvider authDataProvider;

  AuthRepository({required this.authDataProvider});

  Future<String> logIn(String email, String password) async {
    return await authDataProvider.logIn(email, password);
  }

  Future<bool> hasToken() async {
    return await authDataProvider.hasToken();
  }

  Future<void> setToken(String token) async {
    return await authDataProvider.setToken(token);
  }

  Future<void> logOut() async {
    return await authDataProvider.deleteToken();
  }
}
