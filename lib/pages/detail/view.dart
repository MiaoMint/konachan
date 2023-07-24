import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:konachan/api/konachan.dart';
import 'package:konachan/models/post.dart';
import 'package:konachan/pages/main/controller.dart';
import 'package:konachan/pages/search/controller.dart';
import 'package:konachan/widgets/download_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.posts,
    required this.index,
  }) : super(key: key);
  final List<PostModel> posts;
  final int index;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final PageController pageController = PageController(
    initialPage: widget.index,
    // keepPage: true,
  );

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  _content() {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
            itemCount: widget.posts.length,
            controller: pageController,
            itemBuilder: (context, index) {
              final post = widget.posts[index];
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 1000,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DownloadButton(post: post),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Hero(
                              tag: post.id!,
                              child: CachedNetworkImage(
                                imageUrl:
                                    KonachanApi.getImageUrl(post.sampleUrl!),
                                fadeInDuration: const Duration(milliseconds: 0),
                                fadeOutDuration:
                                    const Duration(milliseconds: 0),
                                progressIndicatorBuilder:
                                    (context, child, downloadProgress) {
                                  return Stack(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: KonachanApi.getImageUrl(
                                          post.previewUrl!,
                                        ),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            // tag
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final tag in post.tags!.split(' '))
                                  OutlinedButton(
                                    onPressed: () {
                                      Get.find<SearchPageController>()
                                          .tags
                                          .value = tag;
                                      Get.find<MainController>().index = 4;
                                      Get.find<MainController>()
                                          .textEditingController
                                          .text = tag;
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(tag),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (post.source!.isNotEmpty)
                              InkWell(
                                child: Text(
                                  "Source: ${post.source}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                onTap: () {
                                  launchUrl(Uri.parse(post.source!));
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (MediaQuery.of(context).size.width > 1000)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 10,
                      child: SizedBox(
                        width: 50,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                        ),
                      ),
                    ),
                  if (MediaQuery.of(context).size.width > 1000)
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 10,
                      child: SizedBox(
                        width: 50,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            icon: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      child: _content(),
      onKey: (value) {
        if (value.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }

        if (value.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }

        if (value.isKeyPressed(LogicalKeyboardKey.escape)) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
