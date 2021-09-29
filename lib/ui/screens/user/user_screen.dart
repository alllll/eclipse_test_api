// ignore_for_file: invalid_use_of_protected_member

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eclipse_test_api/domen/controllers/user_controller.dart';
import 'package:eclipse_test_api/domen/model/album_preview.dart';
import 'package:eclipse_test_api/models/index.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[100],
          elevation: 0,
          title: Obx(() {
            return Text(controller.user.value?.username ?? "");
          }),
        ),
        body: SafeArea(child: Obx(() {
          if (controller.user.value != null) {
            return RefreshIndicator(
              onRefresh: () async => controller.refreshScreen(),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Профиль", style: TextStyle(fontSize: 20)),
                          _UserCard(user: controller.user.value!),
                          const Divider(),
                          const Text("Посты", style: TextStyle(fontSize: 20)),
                          _RecentPosts(posts: controller.posts.value),
                          Center(
                            child: Visibility(
                              visible: controller.posts.isNotEmpty,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed("/posts", arguments: {
                                      "id": controller.user.value!.id
                                    });
                                  },
                                  child: const Text("Просмотреть все")),
                            ),
                          ),
                          const Divider(),
                          const Text("Альбомы", style: TextStyle(fontSize: 20)),
                          _UserAlbums(albums: controller.albumsPreviews.value)
                        ],
                      ),
                    ]),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        })));
  }
}

class _UserAlbums extends StatelessWidget {
  const _UserAlbums({Key? key, required this.albums}) : super(key: key);

  final List<AlbumPreview> albums;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: albums.length + 1,
        itemBuilder: (BuildContext context, index) {
          if (albums.isEmpty) {
            return const Center(child: Text("Не найдено альбомов"));
          } else {
            if (index >= albums.length) {
              return GestureDetector(
                onTap: () => Get.toNamed("/albums",
                    arguments: {"id": albums.first.album.userId}),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Просмотреть все"),
                          )
                        ]),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              );
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
                                reverse: (index / 3 == 0) ? true : false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 6),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 3000),
                                autoPlayCurve: Curves.easeInOutSine,
                                enlargeCenterPage: false,
                                scrollDirection: (index / 2 == 1)
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
    return ExtendedImage.network(photo.url,
        borderRadius: BorderRadius.circular(15),
        width: double.infinity,
        fit: BoxFit.fill,
        cache: true,
        retries: 20);
  }
}

class _RecentPosts extends StatelessWidget {
  const _RecentPosts({Key? key, required this.posts}) : super(key: key);

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const Center(child: Text("Постов нет"));
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () =>
                Get.toNamed("/post", arguments: {"id": posts[index].id}),
            child: Card(
              margin: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      posts[index].title,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      posts[index].body,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: posts.length,
      );
    }
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${user.name}"),
            Text("Email: ${user.email}"),
            Text("Phone: ${user.phone}"),
            Text("Website: ${user.website}"),
            Text("Company: ${user.company.name}"),
            Text("BS: ${user.company.bs}"),
            Row(
              children: [
                const Text("Catch phrase:"),
                Text(user.company.catchPhrase,
                    style: const TextStyle(fontStyle: FontStyle.italic))
              ],
            ),
            Text(
                "Address: ${user.address.suite}, ${user.address.street}, ${user.address.city}, ${user.address.zipcode}"),
          ],
        ),
      ),
    );
  }
}
