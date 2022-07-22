import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/myumkm_controller.dart';

class MyumkmView extends GetView<MyumkmController> {
  const MyumkmView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: const WaterDropHeader(),
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
    );
  }
}
