import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konachan/pages/search/controller.dart';
import 'package:konachan/widgets/image_grid.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchPageController c = Get.put(SearchPageController());
    return Obx(
      () => ImageGrid(
        controller: c.scrollController,
        // ignore: invalid_use_of_protected_member
        posts: c.posts.value,
      ),
    );
  }
}
