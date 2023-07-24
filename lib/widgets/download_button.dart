import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konachan/models/post.dart';
import 'package:konachan/pages/download/controller.dart';
import 'package:konachan/pages/library/controller.dart';
import 'package:konachan/utils/wallpaper.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    Key? key,
    required this.post,
    this.iconColor,
    this.iconSize,
    this.iconButtonStyle,
  }) : super(key: key);
  final PostModel post;
  final Color? iconColor;
  final double? iconSize;
  final ButtonStyle? iconButtonStyle;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return IconButton(
        onPressed: () {
          launchUrl(Uri.parse(post.fileUrl!));
        },
        icon: const Icon(Icons.download),
        iconSize: iconSize,
        color: iconColor,
        style: iconButtonStyle,
      );
    }

    final DownloadController downloadController = Get.put(DownloadController());
    final LibraryController libraryController = Get.put(LibraryController());
    return Obx(() {
      final localPost = libraryController.getImage(post.md5!);
      if (localPost != null) {
        return IconButton(
          style: iconButtonStyle,
          onPressed: () {
            WallpaperUtils.setWallPaper(localPost.path);
          },
          icon: Icon(
            Icons.wallpaper,
            color: iconColor,
            size: iconSize,
          ),
        );
      }
      return IconButton(
        style: iconButtonStyle,
        onPressed: () {
          downloadController.download(
              post.previewUrl!, post.fileUrl!, post.md5!);
        },
        icon: downloadController.downlaodList
                .where((element) => element.name == post.md5)
                .isNotEmpty
            ? Icon(
                Icons.downloading,
                color: iconColor,
              )
            : Icon(
                Icons.download,
                color: iconColor,
              ),
        iconSize: iconSize,
      );
    });
  }
}
