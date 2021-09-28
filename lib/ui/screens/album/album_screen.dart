import 'package:carousel_slider/carousel_slider.dart';
import 'package:eclipse_test_api/domen/controllers/album_controller.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AlbumScreen extends GetView<AlbumController> {
  const AlbumScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Альбом"),
      ),
      body: SafeArea(child: Obx(() {
        if (controller.photos.isNotEmpty) {
          return Column(
            children: [
              Text(controller.album.value.title),
              CarouselSlider(
                  items: controller.photos.value
                      .map((photo) => _PhotoItem(photo: photo))
                      .toList(),
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      })),
    );
  }
}

class _PhotoItem extends StatelessWidget {
  const _PhotoItem({Key? key, required this.photo}) : super(key: key);

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image.network(
          photo.url,
          width: double.infinity,
        ),
        Text(photo.title)
      ],
    );
  }
}
