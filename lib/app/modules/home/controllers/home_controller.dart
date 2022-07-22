import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umkm/app/modules/myumkm/views/myumkm_view.dart';
import 'package:umkm/app/modules/profile/views/profile_view.dart';
import 'package:umkm/app/modules/users/views/users_view.dart';
import 'package:umkm/app/routes/app_pages.dart';

import '../../../controllers/auth_controller.dart';
import '../../login/views/login_view.dart';
import '../../umkm/views/umkm_view.dart';

class HomeController extends GetxController {
  final AuthController authC = Get.find();

  final RxInt tabIndex = 0.obs;
  final RxMap displays = {}.obs;

  @override
  void onInit() {
    initDisplay();

    super.onInit();
  }

  Future<void> initDisplay() async {
    if (kDebugMode) {
      print('loggedIn: ${authC.loggedIn.value}');
      print('verified: ${authC.verified.value}');
      print('admin: ${authC.admin.value}');
    }

    if (authC.loggedIn.isTrue && authC.admin.isTrue) {
      displays.value = {
        'icons': [
          navbarItem(Icons.home),
          navbarItem(Icons.list),
          navbarItem(Icons.person)
        ],
        'pages': [
          const UmkmView(),
          const UsersView(),
          const ProfileView(),
        ],
      };
    } else if (authC.loggedIn.isTrue && authC.verified.isTrue) {
      displays.value = {
        'icons': [
          navbarItem(Icons.home),
          navbarItem(Icons.store),
          navbarItem(Icons.person)
        ],
        'pages': [
          const UmkmView(),
          const MyumkmView(),
          const ProfileView(),
        ],
      };
      final isHaveData = await authC.cekData(authC.auth.currentUser!.uid);
      if (!isHaveData) Get.offAllNamed(Routes.register);
    } else {
      displays.value = {
        'icons': [navbarItem(Icons.home), navbarItem(Icons.login)],
        'pages': [const UmkmView(), const LoginView()],
      };
      if (authC.loggedIn.isTrue && authC.verified.isFalse) {
        changeTabIndex(1);
      }
    }
  }

  CustomNavigationBarItem navbarItem(IconData icon) =>
      CustomNavigationBarItem(icon: Icon(icon));
  void changeTabIndex(int index) => tabIndex.value = index;
}
