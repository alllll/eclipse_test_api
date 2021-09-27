import 'package:eclipse_test_api/data/providers/local/hive_provider/hive_provider.dart';
import 'package:eclipse_test_api/data/providers/remote/remote_data_interface.dart';
import 'package:eclipse_test_api/data/repositories/post_repository.dart';
import 'package:eclipse_test_api/data/repositories/user_repository.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/providers/local/local_data_interface.dart';
import 'data/providers/remote/jsonplaceholder_provider/jsonplaceholder_provider.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDb();

  final HiveProvider hiveProvider = HiveProvider();
  Get.put<LocalDataInterface>(hiveProvider, permanent: true);

  final JsonPlaceholderProvider jsonPlaceholderProvider =
      JsonPlaceholderProvider(baseUrl: "https://jsonplaceholder.typicode.com/");
  Get.put<RemoteDataInterface>(jsonPlaceholderProvider, permanent: true);

  Get.put<UserRepository>(UserRepository(), permanent: true);
  Get.put<PostRepository>(PostRepository(), permanent: true);
}

Future<void> initDb() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(GeoAdapter());
  Hive.registerAdapter(CompanyAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(AlbumAdapter());
  Hive.registerAdapter(CommentAdapter());
  Hive.registerAdapter(PhotoAdapter());
  Hive.registerAdapter(PostAdapter());

  final Box users = await Hive.openBox(userBox);
  Get.put<Box>(users, tag: userBox, permanent: true);

  final Box albums = await Hive.openBox(albumBox);
  Get.put<Box>(albums, tag: albumBox, permanent: true);

  final Box comments = await Hive.openBox(commentBox);
  Get.put<Box>(comments, tag: commentBox, permanent: true);

  final Box photos = await Hive.openBox(photoBox);
  Get.put<Box>(photos, tag: photoBox, permanent: true);

  final Box posts = await Hive.openBox(postBox);
  Get.put<Box>(posts, tag: postBox, permanent: true);
}
