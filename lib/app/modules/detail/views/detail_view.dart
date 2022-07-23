import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.data.umkm?.namaUsaha ?? 'Loading...',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          const SizedBox(height: 16),
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 16 / 9,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          'Gambar $i',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ));
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          const SizedBox(
            height: 32,
            child: ListTile(
              dense: true,
              leading: Text('SKU'),
              title: Text(
                '1233235345345',
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            height: 32,
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.category),
              title: Text(
                controller.data.umkm?.jenisUsaha ?? 'Loading...',
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            height: 32,
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.money),
              title: Text(
                controller.data.umkm?.jumlahModal ?? 'Loading...',
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            height: 32,
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.person),
              title: Text(
                controller.data.ktp?.nama ?? 'Loading...',
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            height: 32,
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.group),
              title: Text(
                '${controller.data.umkm?.jumlahTenaga} Pegawai',
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            height: 32,
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.place),
              title: Text(
                controller.data.ktp?.alamat ?? 'Loading...',
              ),
            ),
          ),
          const Divider(),
          SizedBox(
            height: 32,
            child: ListTile(
              dense: true,
              leading: const Icon(Icons.timer),
              title: Text(
                controller.data.status! ? 'Disetujui' : 'Belum Disetujui',
              ),
            ),
          ),
          const Divider(),
        ]),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            backgroundColor: Get.theme.backgroundColor,
            foregroundColor: Colors.black,
            onPressed: () {
              // Respond to button press
            },
            icon: const Icon(Icons.edit),
            label: const Text('Ubah'),
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            backgroundColor: Get.theme.backgroundColor,
            foregroundColor: Colors.black,
            onPressed: () {
              // Respond to button press
            },
            icon: const Icon(Icons.check),
            label: const Text('Setujui'),
          ),
        ],
      ),
    );
  }
}
