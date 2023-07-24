import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final _index = 0.obs;
  int get index => _index.value;
  set index(int value) => _index.value = value;

  final TextEditingController textEditingController = TextEditingController();
}
