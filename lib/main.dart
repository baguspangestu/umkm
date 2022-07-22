import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umkm/app/config/config.dart';
import 'app/controllers/auth_controller.dart';
import 'app/controllers/data_controller.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  Get.put(AuthController(), permanent: true);
  Get.put(DataController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Config.app.name,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: Config.utils.font,
        primarySwatch: Config.utils.colorPrimary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
