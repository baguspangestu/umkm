import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umkm/app/config/string.dart';

class UmkmModel {
  String? uid;
  Timestamp? createdAt;
  Ktp? ktp;
  bool? status;
  Umkm? umkm;

  UmkmModel({this.uid, this.createdAt, this.ktp, this.status, this.umkm});

  UmkmModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    createdAt = json['createdAt'];
    ktp = json['ktp'] != null ? Ktp?.fromJson(json['ktp']) : null;
    status = json['status'] ?? false;
    umkm = json['umkm'] != null ? Umkm?.fromJson(json['umkm']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['createdAt'] = createdAt;
    if (ktp != null) {
      data['ktp'] = ktp?.toJson();
    }
    if (umkm != null) {
      data['umkm'] = umkm?.toJson();
    }
    return data;
  }
}

class Ktp {
  String? nik;
  String? jk;
  String? nama;
  String? alamat;

  Ktp({this.nik, this.jk, this.nama, this.alamat});

  Ktp.fromJson(Map<String, dynamic> json) {
    const dataAlamat = [
      {"id": "181001", "nama": "Pringsewu"},
      {"id": "181002", "nama": "Gading Rejo"},
      {"id": "181003", "nama": "Ambarawa"},
      {"id": "181004", "nama": "Pardasuka"},
      {"id": "181005", "nama": "Pagelaran"},
      {"id": "181006", "nama": "Banyumas"},
      {"id": "181007", "nama": "Adiluwih"},
      {"id": "181008", "nama": "Sukoharjo"},
      {"id": "181009", "nama": "Pagelaran Utara"}
    ];

    getNama(data, id) => data.where((e) => e['id'] == id).first['nama'];

    nik = json['nik'];
    jk = json['jk'] == 'L' ? 'Laki-laki' : 'Perempuan';
    nama = '${json['nama']}'.toTitleCase();
    alamat = getNama(dataAlamat, json['alamat'].substring(0, 6));
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nik'] = nik;
    data['jk'] = jk;
    data['nama'] = nama;
    data['alamat'] = alamat;
    return data;
  }
}

class Umkm {
  String? jumlahTenaga;
  String? jumlahModal;
  String? jenisUsaha;
  String? namaKelompok;
  String? namaUsaha;

  Umkm(
      {this.jumlahTenaga,
      this.jumlahModal,
      this.jenisUsaha,
      this.namaKelompok,
      this.namaUsaha});

  Umkm.fromJson(Map<String, dynamic> json) {
    const dataModalUsaha = [
      {"id": "01", "nama": "Rp 0 - Rp 50.000.000"},
      {"id": "02", "nama": "Rp 50.000.000 - Rp 500.000.000"},
      {"id": "03", "nama": "Rp 500.000.000 - Rp 10.000.000.000"}
    ];

    const dataJenisUsaha = [
      {"id": "01", "nama": "Kuliner"},
      {"id": "02", "nama": "Jasa"},
      {"id": "03", "nama": "Fashion"},
      {"id": "04", "nama": "Kerajinan"},
      {"id": "05", "nama": "Pertanian"}
    ];

    getNama(data, id) => data.where((e) => e['id'] == id).first['nama'];

    jumlahTenaga = json['jumlahTenaga'];
    jumlahModal = getNama(dataModalUsaha, json['jumlahModal']);
    jenisUsaha = getNama(dataJenisUsaha, json['jenisUsaha']);
    namaKelompok = json['namaKelompok'];
    namaUsaha = '${json['namaUsaha']}'.toTitleCase();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['jumlahTenaga'] = jumlahTenaga;
    data['jumlahModal'] = jumlahModal;
    data['jenisUsaha'] = jenisUsaha;
    data['namaKelompok'] = namaKelompok;
    data['namaUsaha'] = namaUsaha;
    return data;
  }
}
