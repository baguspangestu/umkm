import 'package:get/get.dart';

import '../../../data/models/umkm_model.dart';

class DetailController extends GetxController {
  final UmkmModel data = Get.arguments;

  @override
  void onInit() {
    print(data);
    super.onInit();
  }
}
