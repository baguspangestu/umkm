import 'package:flutter/material.dart';

class Config {
  static App app = const App();
}

class App {
  const App();
  String get name => 'UMKM PRINGSEWU';
  String get longName =>
      'USAHA MIKRO KECIL MENENGAH (UMKM) KABUPATEN PRINGSEWU';
  String get version => '1.0.0';
  String get logo => 'assets/images/logo.png';
  MaterialColor get colorPrimary => Colors.green;
  List<String> get adminRole => ['admin.umkmpringsewu@gmail.com'];
}
