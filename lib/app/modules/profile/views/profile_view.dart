import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Obx(
            () => Text(
              controller.authC.admin.isTrue
                  ? 'Admin'
                  : controller.user.isNotEmpty
                      ? controller.user['ktp']['nama'] ?? 'Loading...'
                      : 'Loading...',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            controller.authC.auth.currentUser!.email ?? 'Loading...',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          RoundedLoadingButton(
            controller: controller.btnController,
            onPressed: controller.logout,
            color: Colors.red,
            width: Get.size.width * 0.45,
            child: const Text(
              'Keluar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
