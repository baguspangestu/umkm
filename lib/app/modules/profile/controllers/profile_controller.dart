import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/data_controller.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final AuthController authC = Get.find();
  final DataController dataC = Get.find();

  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  final RxMap user = {}.obs;

  @override
  void onInit() {
    getDataUser();
    super.onInit();
  }

  getDataUser() async {
    final response = await dataC.getDataUser(authC.auth.currentUser!.uid);
    if (response['status']) {
      user.value = response['data'];
    }
  }

  Future<void> logout() async {
    final response = await authC.logout();
    if (response['status']) {
      btnController.success();
      Get.offAllNamed(Routes.home);
    }
  }
}
