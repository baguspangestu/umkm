import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/umkm_controller.dart';

class UmkmView extends GetView<UmkmController> {
  const UmkmView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller.scrollController,
      padding: const EdgeInsets.all(8),
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
              leading: Image.asset('assets/images/pringsewu.png'),
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
    );
  }
}
