import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:konachan/utils/storage.dart';

final Dio dio = Dio();

class DownloadController extends GetxController {
  final downlaodList = <Download>[].obs;
  final maxTask = 3.obs;
  final taskCount = 0.obs;
  final downloadPath = "".obs;
  final imageList = <ImageItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  _init() async {
    downloadPath.value = StroageUtils.downloadPath;
    final dir = Directory(downloadPath.value);
    if (!dir.existsSync()) {
      dir.createSync();
    }
  }

  void download(String previewUrl, String url, String name) async {
    final path = "$downloadPath/$name.png";
    final download = Download(
      previewUrl: previewUrl,
      url: url,
      path: path,
      name: name,
      status: "Waiting",
      progress: 0,
    );
    downlaodList.add(download);
    if (taskCount.value < maxTask.value) {
      _download(download);
    }
  }

  _download(Download download) async {
    taskCount.value++;
    try {
      await dio.download(
        download.url,
        download.path,
        onReceiveProgress: (count, total) {
          download.progress = (count / total * 100).toInt();
          download.status = "Downloading";
          downlaodList.refresh();
        },
      );
      download.status = "Completed";
      downlaodList.remove(download);
      imageList.add(download);
    } catch (e) {
      download.status = "Error";
    } finally {
      downlaodList.refresh();
      taskCount.value--;
      // 寻找下一个任务
      final next = downlaodList
          .where((element) => element.status == "Waiting")
          .firstOrNull;
      if (next != null) {
        _download(next);
      }
    }
  }
}

class ImageItem {
  final String path;
  final String name;

  ImageItem({
    required this.path,
    required this.name,
  });
}

class Download extends ImageItem {
  final String previewUrl;
  final String url;
  String status;
  int progress;

  Download({
    required super.path,
    required super.name,
    required this.status,
    required this.progress,
    required this.previewUrl,
    required this.url,
  });
}
