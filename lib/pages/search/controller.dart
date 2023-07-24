import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:konachan/api/konachan.dart';
import 'package:konachan/models/post.dart';

class SearchPageController extends GetxController {
  final tags = "".obs;
  final page = 1.obs;
  final posts = <PostModel>[].obs;
  final isLoading = false.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    ever(tags, (callback) {
      page.value = 1;
      posts.clear();
      onRefresh();
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoading.value) {
        onRefresh();
      }
    });
    super.onInit();
  }

  onRefresh() async {
    try {
      isLoading.value = true;
      posts.addAll(await KonachanApi.getPosts(page.value, tags: tags.value));
      page.value++;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
