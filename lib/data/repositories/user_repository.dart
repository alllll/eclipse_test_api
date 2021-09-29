import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eclipse_test_api/data/providers/local/local_data_interface.dart';
import 'package:eclipse_test_api/data/providers/remote/remote_data_interface.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class UserRepository {
  final localDataInterface = Get.find<LocalDataInterface>();
  final remoteDataInterface = Get.find<RemoteDataInterface>();
  final connectivity = Connectivity();

  Future<List<User>> fetchUsers() async {
    late List<User> users;
    try {
      users = await localDataInterface.getUsers();
      if (users.isEmpty) {
        final connectivityResult = await connectivity.checkConnectivity();
        if (connectivityResult != ConnectivityResult.none) {
          users = await remoteDataInterface.fetchUsers();
          await localDataInterface.saveUsers(users);
        }
      }
    } catch (err) {
      users = await localDataInterface.getUsers();
      rethrow;
    }
    return users;
  }

  Future<User> fetchUser(int id) async {
    var user = await localDataInterface.getUser(id);
    user ??= await remoteDataInterface.fetchUser(id);
    return user;
  }
}
