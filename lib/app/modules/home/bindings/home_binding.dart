import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../login/controllers/login_controller.dart';
import '../../myumkm/controllers/myumkm_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../umkm/controllers/umkm_controller.dart';
import '../../users/controllers/users_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  final AuthController authC = Get.find();

  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<UmkmController>(
      () => UmkmController(),
    );

    if (authC.loggedin.isTrue && authC.admin.isTrue) {
      Get.lazyPut<UsersController>(
        () => UsersController(),
      );
      Get.lazyPut<ProfileController>(
        () => ProfileController(),
      );
    } else if (authC.loggedin.isTrue && authC.verified.isTrue) {
      Get.lazyPut<MyumkmController>(
        () => MyumkmController(),
      );
      Get.lazyPut<ProfileController>(
        () => ProfileController(),
      );
    } else {
      Get.lazyPut<LoginController>(
        () => LoginController(),
      );
    }
  }
}
