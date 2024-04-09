import '../../data/api/users_data_provider.dart';
import '../../models/users/user_model.dart';

class UserRepository {
  final UserDataProvider userDataProvider;

  UserRepository({required this.userDataProvider});

  Future<List<UserModel>> getUsers(int page) async {
    return await userDataProvider.getUsers(page);
  }
}
