import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final AuthController authC = Get.find();

  Future<void> logout() async {
    final response = await authC.logout();
    if (response['status']) {
      Get.offAllNamed(Routes.home);
    }
  }
}
