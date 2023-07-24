import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konachan/pages/library/controller.dart';
import 'package:konachan/utils/wallpaper.dart'
    if (dart.library.html) 'package:konachan/dont_use_web/wallpaper.dart';
import 'package:url_launcher/url_launcher.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Center(
        child: Text("This feature is not available on web"),
      );
    }
    final LibraryController c = Get.put(LibraryController());
    return Obx(
      () => CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Library"),
            automaticallyImplyLeading: false,
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final image = c.imageList[index];
                return Stack(
                  children: [
                    Image.file(
                      File(image.path),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(image.path));
                          },
                        ),
                      ),
                    ),
                    // 设置壁纸
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        onPressed: () {
                          WallpaperUtils.setWallPaper(image.path);
                        },
                        icon: const Icon(Icons.wallpaper),
                      ),
                    ),
                  ],
                );
              },
              childCount: c.imageList.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width ~/ 350,
              childAspectRatio: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
