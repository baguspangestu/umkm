import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UmkmController extends GetxController {
  final scrollController = ScrollController();
  List<String> items = List.generate(15, (index) => 'Nama UMKM ${index + 1}');

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        items.addAll(List.generate(
            5, (index) => 'Nama UMKM ${items.length + index + 1}'));
        update();
      }
    });
  }
}
