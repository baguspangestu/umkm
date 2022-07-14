// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  final RxBool loggedin = false.obs;
  final RxBool verified = false.obs;
  final RxBool admin = false.obs;

  @override
  Future<void> onInit() async {
    await auth.currentUser?.reload();
    isAuth();
    super.onInit();
  }

  Future<void> isAuth() async {
    try {
      auth.authStateChanges().listen((User? user) {
        if (user != null) {
          loggedin.value = true;
          verified.value = user.emailVerified;
          admin.value = user.email == 'admin.umkmpringsewu@gmail.com';
          print(user);
        } else {
          loggedin.value = false;
          verified.value = false;
          admin.value = false;
        }
      });
    } catch (_) {
      loggedin.value = false;
      verified.value = false;
      admin.value = false;
    }
  }

  Future<Map> register(Map data) async {
    Map<String, Object> response;

    try {
      await auth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      isAuth();
      response = sendVerif() as Map<String, Object>;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response = {
          'status': false,
          'message': 'Password terlalu lemah!',
        };
      } else if (e.code == 'email-already-in-use') {
        response = {
          'status': false,
          'message':
              'Email ini sudah terdaftar, silakan masuk dengan password yang sudah didaftarkan!',
        };
      } else {
        response = {
          'status': false,
          'message': 'Kesalahan tidak diketahui, silakan coba lagi.',
        };
      }
    } catch (_) {
      response = {
        'status': false,
        'message': 'Kesalahan tidak diketahui, silakan coba lagi.',
      };
    }

    return response;
  }

  Future<Map> sendVerif() async {
    final user = auth.currentUser;
    try {
      await user?.sendEmailVerification();
      return {
        'status': true,
        'message': 'Link verifikasi telah dikirim ke email kamu.',
      };
    } catch (_) {
      return {
        'status': false,
        'message': 'Gagal mengirim link verifikasi email!',
      };
    }
  }

  Future<Map> checkVerif() async {
    final user = auth.currentUser;
    try {
      await user?.reload();
      if (user?.emailVerified ?? false) {
        return {
          'status': true,
          'message': 'Email kamu sudah diverifikasi.',
        };
      } else {
        return {
          'status': false,
          'message': 'Email kamu belum diverifikasi.',
        };
      }
    } catch (_) {
      return {
        'status': false,
        'message': 'Gagal memeriksa verifikasi email!',
      };
    }
  }

  Future<Map> forgotPassword(Map data) async {
    try {
      await auth.sendPasswordResetEmail(email: data['email']);
      return {
        'status': true,
        'message': 'Link reset password telah dikirim ke email kamu.',
      };
    } catch (_) {
      return {
        'status': false,
        'message': 'Gagal mengirim link reset password!',
      };
    }
  }

  Future<Map> login(Map data) async {
    Map<String, Object> response;

    try {
      await auth.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      isAuth();
      response = {
        'status': true,
        'message': 'Berhasil Login',
      };
    } catch (_) {
      response = {
        'status': false,
        'message': 'Email atau Password salah!',
      };
    }

    return response;
  }

  Future<Map> logout() async {
    await auth.signOut();
    isAuth();
    return {
      'status': true,
      'message': 'Berhasil Logout',
    };
  }
}
