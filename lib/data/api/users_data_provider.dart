import 'dart:convert';

import 'package:http/http.dart';

import '../../../../../utils/constants.dart';
import '../../../models/users/user_model.dart';
import '../../../utils/exception_handler.dart';

class UserDataProvider {
  List<UserModel> users = [];

  Future<List<UserModel>> getUsers(int page) async {
    try {
      String userUrl = Constants.baseUrl + 'users?page=$page';
      Response response = await get(Uri.parse(userUrl));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)['data'];
        users = result.map((e) => UserModel.fromJson(e)).toList();
      }
      return users;
    } catch (e) {
      throw handleException(e);
    }
  }
}
