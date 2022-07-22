import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../config/config.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'LENGKAPI DATA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          controller.indexForm.value == 0
                              ? Icons.badge
                              : Icons.store,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          controller.indexForm.value == 0
                              ? 'DATA KTP'
                              : 'DATA UMKM',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${controller.indexForm.value + 1}/2',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Obx(
                    () => Form(
                      autovalidateMode: controller.validateMode.value,
                      key: controller.formKey,
                      child: AutofillGroup(
                        child: Visibility(
                          visible: controller.indexForm.value == 1,
                          replacement: Column(
                            children: [
                              InkWell(
                                onTap: () =>
                                    controller.pickKtp(ImageSource.camera),
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  height: Get.size.width * 0.45,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: controller.imageKtp.value == null
                                      ? const Center(
                                          child: Text(
                                            'Upload Foto KTP',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        )
                                      : Image.file(controller.imageKtp.value!),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: controller.dataForm['nik'],
                                validator: controller.validator['nik'],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: '${Config.limit.nik} digit NIK',
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(
                                      Config.limit.nik),
                                ],
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: controller.dataForm['nama'],
                                validator: controller.validator['nama'],
                                autofillHints: const [AutofillHints.name],
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nama Lengkap',
                                ),
                                textCapitalization:
                                    TextCapitalization.characters,
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField(
                                validator: controller.validator['kec'],
                                value: controller.valueGender.value.isEmpty
                                    ? null
                                    : controller.valueGender.value,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.dataGender.isEmpty
                                    ? null
                                    : controller.dataGender.map(
                                        (items) {
                                          return DropdownMenuItem(
                                            value: items['id'],
                                            child: Text(items['nama']),
                                          );
                                        },
                                      ).toList(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Jenis Kelamin',
                                ),
                                onChanged: controller.dataGender.isEmpty
                                    ? null
                                    : controller.onSelectGender,
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField(
                                validator: controller.validator['pro'],
                                value: controller.valuePro.value.isEmpty
                                    ? null
                                    : controller.valuePro.value,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.dataKec.isEmpty
                                    ? null
                                    : controller.dataPro.map(
                                        (items) {
                                          return DropdownMenuItem(
                                            value: items['id'],
                                            child: Text(items['nama']),
                                          );
                                        },
                                      ).toList(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Provinsi',
                                ),
                                onChanged: null,
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField(
                                validator: controller.validator['kab'],
                                value: controller.valueKab.value.isEmpty
                                    ? null
                                    : controller.valueKab.value,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.dataKec.isEmpty
                                    ? null
                                    : controller.dataKab.map(
                                        (items) {
                                          return DropdownMenuItem(
                                            value: items['id'],
                                            child: Text(items['nama']),
                                          );
                                        },
                                      ).toList(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Kabupaten',
                                ),
                                onChanged: null,
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField(
                                validator: controller.validator['kec'],
                                value: controller.valueKec.value.isEmpty
                                    ? null
                                    : controller.valueKec.value,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.dataKec.isEmpty
                                    ? null
                                    : controller.dataKec.map(
                                        (items) {
                                          return DropdownMenuItem(
                                            value: items['id'],
                                            child: Text(items['nama']),
                                          );
                                        },
                                      ).toList(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Kecamatan',
                                ),
                                onChanged: controller.dataKec.isEmpty
                                    ? null
                                    : controller.onSelectKec,
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField(
                                validator: controller.validator['kel'],
                                value: controller.valueKel.value.isEmpty
                                    ? null
                                    : controller.valueKel.value,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.dataKel.isEmpty
                                    ? null
                                    : controller.dataKel.map(
                                        (items) {
                                          return DropdownMenuItem(
                                            value: items['id'],
                                            child: Text(items['nama']),
                                          );
                                        },
                                      ).toList(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Kel/Desa',
                                ),
                                onChanged: controller.dataKel.isEmpty
                                    ? null
                                    : controller.onSelectKel,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.dataForm['nama_usaha'],
                                validator: controller.validator['nama_usaha'],
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nama Usaha',
                                ),
                                textCapitalization:
                                    TextCapitalization.characters,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(
                                      Config.limit.namaUsaha),
                                ],
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField(
                                validator: controller.validator['jenis_usaha'],
                                value: controller.valueJenisUsaha.value.isEmpty
                                    ? null
                                    : controller.valueJenisUsaha.value,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.dataJenisUsaha.isEmpty
                                    ? null
                                    : controller.dataJenisUsaha.map(
                                        (items) {
                                          return DropdownMenuItem(
                                            value: items['id'],
                                            child: Text(items['nama']),
                                          );
                                        },
                                      ).toList(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Jenis Usaha',
                                ),
                                onChanged: controller.dataJenisUsaha.isEmpty
                                    ? null
                                    : controller.onSelectJenisUsaha,
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField(
                                validator: controller.validator['jumlah_modal'],
                                value: controller.valueJumlahModal.value.isEmpty
                                    ? null
                                    : controller.valueJumlahModal.value,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.dataJumlahModal.isEmpty
                                    ? null
                                    : controller.dataJumlahModal.map(
                                        (items) {
                                          return DropdownMenuItem(
                                            value: items['id'],
                                            child: Text(items['nama']),
                                          );
                                        },
                                      ).toList(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Jumlah Aset Modal',
                                ),
                                onChanged: controller.dataJumlahModal.isEmpty
                                    ? null
                                    : controller.onSelectJumlahModal,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller:
                                    controller.dataForm['jumlah_tenaga'],
                                validator:
                                    controller.validator['jumlah_tenaga'],
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Jumlah Tenaga Kerja',
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller:
                                    controller.dataForm['nama_kelompok'],
                                validator:
                                    controller.validator['nama_kelompok'],
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nama Kelompok Usaha (Opsional)',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white54,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Obx(
          () => Visibility(
            visible: controller.indexForm.value == 1,
            replacement: RoundedLoadingButton(
              controller: controller.btnController,
              onPressed: controller.onSwitch,
              color: Get.theme.buttonTheme.colorScheme?.primary,
              width: Get.size.width * 0.9,
              animateOnTap: false,
              child: const Text(
                'Lanjut',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedLoadingButton(
                  controller: controller.btnController,
                  onPressed: controller.onSwitch,
                  color: Colors.grey,
                  width: Get.size.width * 0.45,
                  animateOnTap: false,
                  child: const Text(
                    'Kembali',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RoundedLoadingButton(
                  controller: controller.btnController,
                  onPressed: controller.onSubmit,
                  color: Get.theme.buttonTheme.colorScheme?.primary,
                  width: Get.size.width * 0.45,
                  child: const Text(
                    'Selesai',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
