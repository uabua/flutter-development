import 'package:assignment_05/data/models/user.dart';
import 'package:dio/dio.dart';

class UserRepository {
  List<User>? users = [];
  Dio dio = Dio();

  Future<List<User>>? fetchUsers() async {
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/users');

    if (response.statusCode == 200) {
      List<User> loadedUsers = [];

      response.data.forEach((user) {
        var userModel = User.fromJson(user);
        loadedUsers.add(userModel);
        users = loadedUsers;

        return users!;
      });
    }

    return users!;
  }
}
