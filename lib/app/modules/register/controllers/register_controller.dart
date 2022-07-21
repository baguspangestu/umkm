import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:umkm/app/config/config.dart';

class RegisterController extends GetxController {
  final RxInt indexForm = 0.obs;

  final RxList dataKec = [].obs;
  final RxList dataKel = [].obs;
  final RxString valueKec = ''.obs;
  final RxString valueKel = ''.obs;

  final Rx validateMode = AutovalidateMode.disabled.obs;
  final formKey = GlobalKey<FormState>();
  final dataForm = {
    'nik': TextEditingController(),
    'nama': TextEditingController(),
  };
  final validator = {}.obs;

  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  @override
  void onInit() {
    getKecamatan('1810');
    validators();
    super.onInit();
  }

  void validators() {
    validator.value = {
      'nik': (value) {
        if (value.isEmpty) {
          return 'NIK wajib diisi!';
        } else if (value.length != Config.limit.nik) {
          return 'NIK tidak valid!';
        }
        return null;
      },
      'nama': (value) {
        if (value.isEmpty) {
          return 'Nama Lengkap wajib diisi!';
        }
        return null;
      },
      'kec': (value) {
        if (value == null) {
          return 'Kecamatan wajib dipilih!';
        }
        return null;
      },
      'kel': (value) {
        if (value == null) {
          return 'Kel/Desa wajib dipilih!';
        }
        return null;
      }
    };
  }

  Future<void> getKecamatan(String id) async {
    try {
      final String path = Config.data.kecamatan(id);
      final String response = await rootBundle.loadString(path);
      dataKec.value = await json.decode(response);
    } catch (_) {
      dataKec.value = [];
    }
  }

  Future<void> getKelurahan(String id) async {
    try {
      final String path = Config.data.kelurahan(id);
      final String response = await rootBundle.loadString(path);
      dataKel.value = await json.decode(response);
    } catch (_) {
      dataKel.value = [];
    }
  }

  void onSelectKec(value) {
    final String kecamatan = value.toString();
    valueKel.value = '';
    valueKec.value = kecamatan;
    getKelurahan(kecamatan);
  }

  void onSelectKel(value) => valueKel.value = value.toString();

  void onSwitch() {
    validateMode.value = AutovalidateMode.onUserInteraction;
    final isValidForm = formKey.currentState!.validate();

    if (indexForm.value == 1) {
      indexForm.value--;
    } else if (isValidForm) {
      validateMode.value = AutovalidateMode.disabled;
      indexForm.value++;
    }
  }

  void onSubmit() {}
}
