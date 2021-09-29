import 'package:carousel_slider/carousel_slider.dart';
import 'package:eclipse_test_api/domen/controllers/albums_controller.dart';
import 'package:eclipse_test_api/domen/model/album_preview.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:extended_image/extended_image.dart';
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
        backgroundColor: Colors.green[100],
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        CarouselSlider(
                            key: UniqueKey(),
                            items: albums[index]
                                .photo
                                .map((photo) => _AlbumItem(
                                    title: albums[index].album.title,
                                    photo: photo))
                                .toList(),
                            options: CarouselOptions(
                              height: double.infinity,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: (index % 3 == 0) ? true : false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 6),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 3000),
                              autoPlayCurve: Curves.easeInOutSine,
                              enlargeCenterPage: false,
                              scrollDirection: (index % 3 == 1)
                                  ? Axis.horizontal
                                  : Axis.vertical,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(albums[index].album.title),
                        ),
                      ]),
                ),
              ),
            );
          }
        });
  }
}

class _AlbumItem extends StatelessWidget {
  const _AlbumItem({Key? key, required this.title, required this.photo})
      : super(key: key);

  final Photo photo;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      photo.url,
      borderRadius: BorderRadius.circular(15),
      width: double.infinity,
      fit: BoxFit.fill,
      cache: true,
    );
  }
}
