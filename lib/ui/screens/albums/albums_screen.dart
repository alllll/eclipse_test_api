import 'package:eclipse_test_api/domen/controllers/albums_controller.dart';
import 'package:eclipse_test_api/domen/controllers/posts_controller.dart';
import 'package:eclipse_test_api/domen/model/album_preview.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AlbumsScreen extends GetView<AlbumsController> {
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Все альбомы"),
      ),
      body: SafeArea(child: Obx(() {
        if (controller.albumsPreviews.isNotEmpty) {
          return _Albums(albums: controller.albumsPreviews);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      })),
    );
  }
}

class _Albums extends StatelessWidget {
  const _Albums({Key? key, required this.albums}) : super(key: key);

  final List<AlbumPreview> albums;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: albums.length,
        itemBuilder: (BuildContext context, index) {
          if (albums.isEmpty) {
            return Container();
          } else {
            return GestureDetector(
              onTap: () => Get.toNamed("/album",
                  arguments: {"id": albums[index].album.id}),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(albums[index].album.title,
                              style: TextStyle(fontSize: 10)),
                        )
                      ]),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              albums[index].photo[0].thumbnailUrl)),
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            );
          }
        });
  }
}
