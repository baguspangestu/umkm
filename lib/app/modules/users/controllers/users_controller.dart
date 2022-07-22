import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../controllers/data_controller.dart';
import '../../../data/models/umkm_model.dart';

class UsersController extends GetxController {
  final DataController dataC = Get.find();
  final scrollController = ScrollController();

  final List items = [];

  @override
  Future<void> onInit() async {
    initDataUmkm(0, false);
    /* scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        initDataUmkm(0, false);
      }
    }); */
    super.onInit();
  }

  initDataUmkm(int o, bool status) async {
    final response = await dataC.getDataUmkm(o, status);
    if (response['status']) {
      items.addAll(response['data']
          .map((doc) => UmkmModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
      update();
    }
  }

  getJenisUsaha(id) async => await dataC.getJenisUsaha(id);

  Future<String> getAlamat(String id) =>
      dataC.getAlamat(id).then((value) => value[0] + ', ' + value[1]);

  Future<void> onSwitch(int index) async {
    items.clear();
    await initDataUmkm(index, false);
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    items.clear();
    await initDataUmkm(0, false);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await initDataUmkm(0, false);
    refreshController.loadComplete();
  }
}
