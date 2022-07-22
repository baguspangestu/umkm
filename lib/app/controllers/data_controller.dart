import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:umkm/app/config/config.dart';
import 'auth_controller.dart';

class DataController extends GetxController {
  final AuthController authC = Get.find();

  final CollectionReference umkmCollection =
      FirebaseFirestore.instance.collection('umkm');

  Future<Map> getDataUmkm(int o, bool status) async {
    final orderBy = o == 1 || o == 2 ? 'nama' : 'createdAt';
    final descending = o != 1;
    return await umkmCollection
        .where('status', isEqualTo: status)
        .orderBy(orderBy, descending: descending)
        .limit(50)
        .get()
        .then((value) => {
              'status': true,
              'message': 'Data berhasil diambil',
              'data': value.docs,
            })
        .catchError(
          (_) => {
            'status': false,
            'message': 'Data gagal diambil',
          },
        );
  }

  Future<Map> getDataUser(uid) async {
    return await umkmCollection
        .doc(uid)
        .get()
        .then((value) => {
              'status': true,
              'message': 'Data berhasil diambil',
              'data': value.data(),
            })
        .catchError(
          (_) => {
            'status': false,
            'message': 'Data gagal diambil',
          },
        );
  }

  Future<List> getAlamat(String id) async {
    try {
      final String idKec = id.substring(0, 6);
      final String idKab = id.substring(0, 4);
      final String idPro = id.substring(0, 2);

      Future<String> getNama(path, id) async {
        final String response = await rootBundle.loadString(path);
        final res = await json.decode(response);
        final get = res.where((e) => e['id'] == id);
        return get.first['nama'];
      }

      final String kelurahanPath = Config.data.kelurahan(idKec);
      final String kecamatanPath = Config.data.kecamatan(idKab);
      final String kabupatenPath = Config.data.kabupaten(idPro);
      final String provinsiPath = Config.data.provinsi;

      final kel = await getNama(kelurahanPath, id).then((value) => value);
      final kec = await getNama(kecamatanPath, idKec).then((value) => value);
      final kab = await getNama(kabupatenPath, idKab).then((value) => value);
      final pro = await getNama(provinsiPath, idPro).then((value) => value);

      return [kel, kec, kab, pro];
    } catch (_) {
      return [];
    }
  }

  getJenisUsaha(String id) async {
    try {
      final String response =
          await rootBundle.loadString(Config.data.jenisUsaha);
      final res = await json.decode(response);
      final get = res.where((e) => e['id'] == id);
      return get.first['nama'];
    } catch (_) {
      return '-';
    }
  }
}
