import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:umkm/app/config/config.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final AuthController authC = Get.find();
  final RxInt indexForm = 0.obs;

  final Rx<File?> imageKtp = null.obs;

  final RxString valueGender = ''.obs;
  final RxList dataGender = [].obs;

  final RxString valuePro = '18'.obs; // id Provinsi Lampung
  final RxString valueKab = '1810'.obs; // id Kabupaten Pringsewu
  final RxString valueKec = ''.obs;
  final RxString valueKel = ''.obs;

  final RxList dataPro = [].obs;
  final RxList dataKab = [].obs;
  final RxList dataKec = [].obs;
  final RxList dataKel = [].obs;

  final RxString valueJenisUsaha = ''.obs;
  final RxString valueJumlahModal = ''.obs;

  final RxList dataJenisUsaha = [].obs;
  final RxList dataJumlahModal = [].obs;

  final Rx validateMode = AutovalidateMode.disabled.obs;
  final formKey = GlobalKey<FormState>();
  final dataForm = {
    'nik': TextEditingController(),
    'nama': TextEditingController(),
    'nama_usaha': TextEditingController(),
    'jumlah_tenaga': TextEditingController(),
    'nama_kelompok': TextEditingController(),
  };
  final validator = {}.obs;

  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  @override
  void onInit() {
    validators();
    getGender();
    getProvinsi();
    getKabupaten(valuePro.value); //18 = Lampung
    getKecamatan(valueKab.value); //1810 = Kabupaten Pringsewu
    getJenisUsaha();
    getJumlahModal();
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
      'gender': (value) {
        if (value == null) {
          return 'Jenus Kelamin wajib dipilih!';
        }
        return null;
      },
      'prov': (value) {
        if (value == null) {
          return 'Provinsi wajib dipilih!';
        }
        return null;
      },
      'kab': (value) {
        if (value == null) {
          return 'Kabuaten wajib dipilih!';
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
      },
      'nama_usaha': (value) {
        if (value.isEmpty) {
          return 'Nama Usaha wajib diisi!';
        } else if (value.length > Config.limit.namaUsaha) {
          return 'Nama Usaha tidak boleh lebih dari 30 karakter!';
        }
        return null;
      },
      'bidang_usaha': (value) {
        if (value == null) {
          return 'Bidang Usaha wajib dipilih!';
        }
        return null;
      },
      'jenis_usaha': (value) {
        if (value == null) {
          return 'Jenis Usaha wajib dipilih!';
        }
        return null;
      },
      'jumlah_modal': (value) {
        if (value == null) {
          return 'JKumlah Modal wajib dipilih!';
        }
        return null;
      },
      'jumlah_tenaga': (value) {
        if (value.isEmpty) {
          return 'Jumlah Tenaga Kerja wajib diisi!';
        }
        return null;
      },
      'nama_kelompok': (value) => null,
    };
  }

  Future<void> getGender() async {
    try {
      final String path = Config.data.gender;
      final String response = await rootBundle.loadString(path);
      dataGender.value = await json.decode(response);
    } catch (_) {
      dataGender.value = [];
    }
  }

  void onSelectGender(value) => valueGender.value = value.toString();

  Future<void> getProvinsi() async {
    try {
      final String path = Config.data.provinsi;
      final String response = await rootBundle.loadString(path);
      dataPro.value = await json.decode(response);
    } catch (_) {
      dataPro.value = [];
    }
  }

  Future<void> getKabupaten(String id) async {
    try {
      final String path = Config.data.kabupaten(id);
      final String response = await rootBundle.loadString(path);
      dataKab.value = await json.decode(response);
    } catch (_) {
      dataKab.value = [];
    }
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

  Future<void> pickKtp(ImageSource image) async {
    try {
      final XFile? ktp = await ImagePicker().pickImage(source: image);
      if (ktp == null) return;
      imageKtp.value = File(ktp.path);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('bjir kok error $e');
      }
    }
  }

  Future<void> getJenisUsaha() async {
    try {
      final String path = Config.data.jenisUsaha;
      final String response = await rootBundle.loadString(path);
      dataJenisUsaha.value = await json.decode(response);
    } catch (_) {
      dataJenisUsaha.value = [];
    }
  }

  Future<void> getJumlahModal() async {
    try {
      final String path = Config.data.jumlahModal;
      final String response = await rootBundle.loadString(path);
      dataJumlahModal.value = await json.decode(response);
    } catch (_) {
      dataJumlahModal.value = [];
    }
  }

  void onSelectJenisUsaha(value) => valueJenisUsaha.value = value.toString();
  void onSelectJumlahModal(value) => valueJumlahModal.value = value.toString();

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

  Future<void> onSubmit() async {
    validateMode.value = AutovalidateMode.onUserInteraction;
    final isValidForm = formKey.currentState!.validate();
    if (isValidForm) {
      final data = {
        'ktp': {
          'nik': dataForm['nik']?.text,
          'nama': dataForm['nama']?.text,
          'jk': valueGender.value,
          'alamat': valueKel.value
        },
        'umkm': {
          'namaUsaha': dataForm['nama_usaha']?.text,
          'jenisUsaha': valueJenisUsaha.value,
          'jumlahModal': valueJumlahModal.value,
          'jumlahTenaga': dataForm['jumlah_tenaga']?.text,
          'namaKelompok': dataForm['nama_kelompok']?.text,
        }
      };

      final Map response = await authC.inputData(data);

      if (response['status']) {
        btnController.success();
        Timer(const Duration(milliseconds: 500), () async {
          Get.offAllNamed(Routes.home);
        });
      } else {
        btnController.error();
        Timer(const Duration(milliseconds: 500), () async {
          btnController.reset();
        });
      }
    } else {
      btnController.reset();
    }
  }
}
