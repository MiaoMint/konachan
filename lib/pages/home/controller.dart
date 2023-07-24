import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:konachan/api/konachan.dart';
import 'package:konachan/models/post.dart';

class HomeController extends GetxController {
  final posts = <PostModel>[].obs;
  final page = 1.obs;
  final isLoading = false.obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoading.value) {
        onRefresh();
      }
    });
    onRefresh();
  }

  Future<void> onRefresh() async {
    try {
      isLoading.value = true;
      posts.addAll((await KonachanApi.getPosts(page.value)));
      page.value++;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
