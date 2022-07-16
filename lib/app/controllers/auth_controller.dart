import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:umkm/app/config/config.dart';

import '../routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final RxBool loggedIn = false.obs;
  final RxBool verified = false.obs;
  final RxBool admin = false.obs;

  @override
  Future<void> onInit() async {
    isAuth();
    super.onInit();
  }

  void isAuth() async {
    try {
      auth.authStateChanges().listen((User? user) {
        if (user != null) {
          cuVar(user);
          reAuth(user);
        } else {
          deVar();
        }
      });
    } catch (_) {
      deVar();
    }
  }

  Future<void> reAuth(User user) async {
    try {
      await auth.currentUser!.reload();
      final reloadedUser = auth.currentUser;
      if (reloadedUser != null) {
        if (user.emailVerified != reloadedUser.emailVerified) {
          Get.offAllNamed(Routes.home);
        }
      } else {
        deVar();
      }
    } catch (_) {
      deVar();
    }
  }

  void cuVar(User user) {
    loggedIn.value = true;
    verified.value = user.emailVerified;
    admin.value = Config.app.adminRole.contains(user.email);
  }

  void deVar() {
    loggedIn.value = false;
    verified.value = false;
    admin.value = false;
  }

  Future<Map> register(Map data) async {
    Map<String, Object> response;

    try {
      await auth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      response = {
        'status': true,
        'message': 'Berhasil mendaftar',
      };
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
          'message': e.code,
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
    try {
      await auth.currentUser?.sendEmailVerification();
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
    try {
      await auth.currentUser?.reload();
      final user = auth.currentUser!;
      if (user.emailVerified) {
        Timer(const Duration(milliseconds: 500), () {
          cuVar(user);
          Get.offAllNamed(Routes.home);
        });
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
        'message':
            'Link reset password telah dikirim ke email kamu, silakan cek di folder spam jika tidak ada, kemudian login dengan password baru.',
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return {
          'status': false,
          'message': 'Email ini tidak terdaftar!',
        };
      } else {
        return {
          'status': false,
          'message': e.message,
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Kesalahan tidak diketahui, silakan coba lagi.',
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
      response = {
        'status': true,
        'message': 'Berhasil Login',
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        response = {
          'status': false,
          'message': 'Terlalu banyak percobaan login, coba lagi nanti!',
        };
      } else {
        response = {
          'status': false,
          'message': 'Email atau Password salah!',
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

  Future<Map> logout() async {
    await auth.signOut();
    isAuth();
    return {
      'status': true,
      'message': 'Berhasil Logout',
    };
  }
}
