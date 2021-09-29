import 'package:eclipse_test_api/data/providers/local/local_data_interface.dart';
import 'package:eclipse_test_api/data/providers/remote/remote_data_interface.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class UserRepository {
  final localDataInterface = Get.find<LocalDataInterface>();
  final remoteDataInterface = Get.find<RemoteDataInterface>();

  Future<List<User>> fetchUsers() async {
    late List<User> users;
    try {
      users = await localDataInterface.getUsers();
      if (users.isEmpty) {
        users = await remoteDataInterface.fetchUsers();
        await localDataInterface.saveUsers(users);
      } else {
        print("users from cache");
      }
    } catch (err) {
      print("users from cache");
      users = await localDataInterface.getUsers();
    }
    return users;
  }

  Future<User> fetchUser(int id) async {
    var user = await localDataInterface.getUser(id);
    if (user != null) print("User from cache!");
    user ??= await remoteDataInterface.fetchUser(id);

    return user;
  }
}
