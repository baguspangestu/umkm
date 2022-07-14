import 'package:get/get.dart';

import '../controllers/myumkm_controller.dart';

class MyumkmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyumkmController>(
      () => MyumkmController(),
    );
  }
}
