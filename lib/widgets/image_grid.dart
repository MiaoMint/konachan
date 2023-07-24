import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:konachan/api/konachan.dart';
import 'package:konachan/models/post.dart';
import 'package:konachan/pages/detail/view.dart';
import 'package:konachan/widgets/download_button.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({
    Key? key,
    required this.controller,
    required this.posts,
  }) : super(key: key);
  final ScrollController controller;
  final List<PostModel> posts;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox.expand(
          child: GridView.builder(
            controller: controller,
            itemCount: posts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: width < 600 ? 2 : width ~/ 300,
              childAspectRatio: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              final post = posts[index];
              return Stack(
                children: [
                  Hero(
                    tag: post.id!,
                    child: CachedNetworkImage(
                      imageUrl: KonachanApi.getImageUrl(post.previewUrl!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned.fill(
                      child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            // 透明背景
                            opaque: false,
                            barrierColor: Colors.black.withOpacity(0.5),
                            pageBuilder: (
                              BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                            ) {
                              return FadeTransition(
                                opacity: animation,
                                child: DetailPage(posts: posts, index: index),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      child: DownloadButton(
                        post: post,
                        iconColor: Colors.black,
                        iconSize: 20,
                        iconButtonStyle: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(0),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            const Size(0, 0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      child: Text(
                        "${post.width}x${post.height}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (posts.isEmpty)
          const Positioned.fill(
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
