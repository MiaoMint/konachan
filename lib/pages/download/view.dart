import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konachan/pages/download/controller.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DownloadController c = Get.put(DownloadController());
    if (kIsWeb) {
      return const Center(
        child: Text("This feature is not available on web"),
      );
    }
    return Obx(
      () => CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Download"),
            automaticallyImplyLeading: false,
          ),
          SliverList.builder(
            itemBuilder: (context, index) {
              final download = c.downlaodList.reversed.toList()[index];
              return ListTile(
                title: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: download.previewUrl,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(download.name),
                        const SizedBox(height: 8),
                        Text(download.status),
                      ],
                    )
                  ],
                ),

                // 设置壁纸
                trailing: Text("${download.progress}%"),
              );
            },
            itemCount: c.downlaodList.length,
          ),
          if (c.downlaodList.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Text("No Task"),
              ),
            ),
        ],
      ),
    );
  }
}
