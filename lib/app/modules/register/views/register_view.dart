import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
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
      body: SingleChildScrollView(
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
                        TextFormField(
                          controller: controller.dataForm['nik'],
                          validator: controller.validator['nik'],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: '${Config.limit.nik} digit NIK',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(Config.limit.nik),
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
                          textCapitalization: TextCapitalization.characters,
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
                          controller: controller.dataForm['nik'],
                          validator: controller.validator['nik'],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: '${Config.limit.nik} digit NIK',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(Config.limit.nik),
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
                            labelText: 'Nama UMKM',
                          ),
                          textCapitalization: TextCapitalization.characters,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
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
