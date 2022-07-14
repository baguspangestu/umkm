import 'package:get/get.dart';
import '../../login/controllers/login_controller.dart';
import '../../myumkm/controllers/myumkm_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../umkm/controllers/umkm_controller.dart';
import '../../users/controllers/users_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<UmkmController>(
      () => UmkmController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<UsersController>(
      () => UsersController(),
    );
    Get.lazyPut<MyumkmController>(
      () => MyumkmController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
