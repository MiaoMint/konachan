import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konachan/pages/home/controller.dart';
import 'package:konachan/widgets/image_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.put(HomeController());
    return Obx(
      () => ImageGrid(
        controller: c.scrollController,
        // ignore: invalid_use_of_protected_member
        posts: c.posts.value,
      ),
    );
  }
}
