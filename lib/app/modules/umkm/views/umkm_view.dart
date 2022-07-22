import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../config/config.dart';
import '../controllers/umkm_controller.dart';

class UmkmView extends GetView<UmkmController> {
  const UmkmView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(UmkmController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(left: 8),
          child: ToggleSwitch(
            initialLabelIndex: 0,
            totalSwitches: 3,
            minWidth: Get.width,
            inactiveBgColor: Get.theme.backgroundColor,
            inactiveFgColor: Colors.black54,
            labels: const ['Terbaru', '(A-Z)', '(Z-A)'],
            onToggle: (index) => controller.onSwitch(index!),
          ),
        ),
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            header: const WaterDropHeader(),
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child: GetBuilder<UmkmController>(
              builder: (umkmC) {
                return umkmC.items.isNotEmpty
                    ? ListView.builder(
                        controller: controller.scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: controller.items.length,
                        itemBuilder: (_, index) {
                          if (index < controller.items.length) {
                            final item = umkmC.items[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ListTile(
                                onTap: () => Get.toNamed(
                                  '/detail',
                                  arguments: item,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                contentPadding: const EdgeInsets.all(8),
                                leading: Image.asset(Config.utils.logo),
                                title: Text(
                                  item.umkm.namaUsaha,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.category,
                                          size: 12,
                                        ),
                                        const SizedBox(width: 4),
                                        Flexible(
                                          child: Text(
                                            item.umkm.jenisUsaha,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          size: 12,
                                        ),
                                        const SizedBox(width: 4),
                                        Flexible(
                                          child: Text(
                                            item.ktp.nama,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.place,
                                          size: 12,
                                        ),
                                        const SizedBox(width: 4),
                                        Flexible(
                                          child: Text(
                                            item.ktp.alamat,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 32,
                            ),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 32,
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}
