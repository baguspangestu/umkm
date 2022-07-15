import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../config/config.dart';
import '../controllers/umkm_controller.dart';

class UmkmView extends GetView<UmkmController> {
  const UmkmView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
            onToggle: (index) {
              if (kDebugMode) {
                print('switched to: $index');
              }
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: controller.scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: controller.items.length + 1,
            itemBuilder: (_, index) {
              if (index < controller.items.length) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    onTap: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.all(8),
                    leading: Image.asset(Config.app.logo),
                    title: Text(
                      controller.items[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.category,
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                'Kuliner',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.person,
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                'Kentas Adi Saputra',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.place,
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                'Pringsewu',
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
          ),
        ),
      ],
    );
  }
}
