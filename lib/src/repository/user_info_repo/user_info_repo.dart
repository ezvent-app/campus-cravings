import 'dart:async';
import 'package:campuscravings/src/src.dart';

import '../../models/User Model/user_info_model.dart';

class UserInfoRepository {
  final HttpAPIServices services = HttpAPIServices();

  Future<UserModel> fetchUserProfile() async {
    try {
      final response = await services.getAPI('/user/');
      print('User Info Response: ${response.body}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = UserModel.fromJson(data);

        print('Parsed UserModel: ${user.toJson()}');
        return UserModel.fromJson(data);
      } else {
        return Future.error(
          'Failed to load user data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is TimeoutException) {
        return Future.error('Request timed out. Please try again.');
      } else {
        print(e.toString());
        return Future.error('Something went wrong');
      }
    }
  }
}
