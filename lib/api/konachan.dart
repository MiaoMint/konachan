import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:konachan/models/post.dart';

Dio dio = Dio(
  BaseOptions(
    baseUrl: kIsWeb ? "/api" : "https://konachan.net",
    headers: {
      "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
              "(KHTML, like Gecko) Chrome/93.0.4577.82 Safari/537.36",
    },
  ),
);

class KonachanApi {
  static Future<List<PostModel>> getPosts(int page, {String tags = ""}) async {
    final list = await dio.get("/post.json", queryParameters: {
      "page": page,
      "limit": 100,
      "tags": tags,
    });
    final posts = List<PostModel>.from(
      list.data.map((e) => PostModel.fromJson(e)),
    );
    posts.removeWhere((element) => element.rating != "s");
    debugPrint(posts.length.toString());
    return posts;
  }

  static getImageUrl(String url) {
    return kIsWeb ? url.replaceFirst("https://konachan.net", "/api") : url;
  }
}
