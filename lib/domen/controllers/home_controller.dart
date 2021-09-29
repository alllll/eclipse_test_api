import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eclipse_test_api/data/repositories/user_repository.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final userRepository = Get.find<UserRepository>();
  late RxList<User> users;

  final Connectivity _connectivity = Connectivity();
  // ignore: unused_field
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  HomeController() {
    users = RxList.empty(growable: true);
    _initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void fetchUsers() async {
    try {
      users.value = await userRepository.fetchUsers();
    } catch (err) {
      return;
    }
  }

  Future<void> _initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } catch (err) {
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    fetchUsers();
  }
}
