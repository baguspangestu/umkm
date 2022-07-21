import 'package:flutter/material.dart';

class Config {
  static App app = const App();
  static Utils utils = const Utils();
  static Limit limit = const Limit();
  static Data data = const Data();
}

class App {
  const App();
  String get name => 'UMKM PRINGSEWU';
  String get fullName => 'UMKM KABUPATEN PRINGSEWU';
  String get longName =>
      'USAHA MIKRO KECIL MENENGAH (UMKM) KABUPATEN PRINGSEWU';
  String get version => '1.0.0';
  String get copyright => '©2022';
  String get developer => 'Kentas Adi Saputra';
  List<String> get adminRole => ['admin.umkmpringsewu@gmail.com'];
}

class Utils {
  const Utils();
  String get font => 'Lato';
  String get logo => 'assets/images/logo.png';
  MaterialColor get colorPrimary => Colors.green;
  MaterialColor get colorSecondary => Colors.grey;
}

class Limit {
  const Limit();
  int get nik => 16;
}

class Data {
  const Data();
  String kecamatan(id) => 'assets/data/kecamatan/$id.json';
  String kelurahan(id) => 'assets/data/kelurahan/$id.json';
}
