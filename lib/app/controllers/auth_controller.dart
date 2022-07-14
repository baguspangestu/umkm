import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  final RxBool loggedin = false.obs;
  final RxBool verified = false.obs;
  final RxBool admin = false.obs;

  @override
  Future<void> onInit() async {
    auth.currentUser?.reload();
    await isAuth();
    super.onInit();
  }

  Future<void> isAuth() async {
    try {
      auth.authStateChanges().listen((User? user) {
        if (user != null) {
          loggedin.value = true;
          verified.value = user.emailVerified;
          admin.value = user.email == 'admin.umkmpringsewu@gmail.com';
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
      final user = auth.currentUser;
      loggedin.value = user != null ? true : false;
      verified.value = user?.emailVerified ?? false;
      admin.value = user?.email == 'admin.umkmpringsewu@gmail.com';
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
      await isAuth();
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
    await isAuth();
    return {
      'status': true,
      'message': 'Berhasil Logout',
    };
  }
}
