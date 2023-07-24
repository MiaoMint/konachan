import 'dart:io';

import 'package:get/get.dart';
import 'package:konachan/pages/download/controller.dart';
import 'package:konachan/utils/storage.dart';

class LibraryController extends GetxController {
  final imageList = <ImageItem>[].obs;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  _init() async {
    final dir = Directory(StroageUtils.downloadPath);
    _readImages(dir);
    dir.watch().listen((event) {
      _readImages(dir);
    });
  }

  _readImages(Directory dir) async {
    final list = dir.listSync();
    imageList.clear();
    for (final item in list) {
      if (item is File && item.path.endsWith(".png")) {
        imageList.add(ImageItem(
          path: item.path,
          name: item.path.split("\\").last,
        ));
      }
    }
  }

  ImageItem? getImage(String md5) {
    return imageList.where((element) => element.name.contains(md5)).firstOrNull;
  }
}
