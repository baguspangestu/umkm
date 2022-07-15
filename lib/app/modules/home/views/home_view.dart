import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umkm/app/config/config.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: Get.height * 0.1,
            title: ListTile(
              leading: Image.asset(Config.app.logo),
              title: const Text(
                'USAHA MIKRO KECIL MENENGAH (UMKM) KABUPATEN PRINGSEWU',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Obx(
              () => IndexedStack(
                index: controller.tabIndex.value,
                children: controller.displays['pages'],
              ),
            ),
          ),
          bottomNavigationBar: Obx(
            () => CustomNavigationBar(
              iconSize: 30.0,
              selectedColor: Colors.white,
              strokeColor: Colors.white,
              unSelectedColor: const Color(0xff6c788a),
              backgroundColor: const Color(0xff040307),
              items: controller.displays['icons'],
              currentIndex: controller.tabIndex.value,
              onTap: controller.changeTabIndex,
            ),
          ),
        );
      },
    );
  }
}
