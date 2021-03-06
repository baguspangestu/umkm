import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:umkm/app/config/config.dart';

import '../routes/app_pages.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final RxBool loggedIn = false.obs;
  final RxBool verified = false.obs;
  final RxBool admin = false.obs;

  final CollectionReference umkmCollection =
      FirebaseFirestore.instance.collection('umkm');

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
    try {
      await auth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      return {
        'status': true,
        'message': 'Berhasil mendaftar',
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return {
          'status': false,
          'message': 'Password terlalu lemah!',
        };
      } else if (e.code == 'email-already-in-use') {
        return {
          'status': false,
          'message':
              'Email ini sudah terdaftar, silakan masuk dengan password yang sudah didaftarkan!',
        };
      } else {
        return {
          'status': false,
          'message': e.code,
        };
      }
    } catch (_) {
      return {
        'status': false,
        'message': 'Kesalahan tidak diketahui, silakan coba lagi.',
      };
    }
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return {
          'status': false,
          'message': 'Email kamu belum terdaftar.',
        };
      } else {
        return {
          'status': false,
          'message': e.message,
        };
      }
    } catch (_) {
      return {
        'status': false,
        'message': 'Kesalahan tidak diketahui, silakan coba lagi.',
      };
    }
  }

  Future<Map> forgotPassword(Map data) async {
    try {
      await auth.sendPasswordResetEmail(email: data['email']);
      return {
        'status': true,
        'message':
            'Link reset password telah dikirim ke email kamu, silakan cek di folder spam jika tidak ada. Jika sudah membuat password baru, silakan login menggunakan password baru.',
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
    try {
      await auth.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      return {
        'status': true,
        'message': 'Berhasil Login',
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        return {
          'status': false,
          'message': 'Terlalu banyak percobaan login, coba lagi nanti!',
        };
      } else {
        return {
          'status': false,
          'message': 'Email atau Password salah!',
        };
      }
    } catch (_) {
      return {
        'status': false,
        'message': 'Kesalahan tidak diketahui, silakan coba lagi.',
      };
    }
  }

  Future<Map> logout() async {
    await auth.signOut();
    isAuth();
    return {
      'status': true,
      'message': 'Berhasil Logout',
    };
  }

  Future<bool> cekData(uid) async {
    return await umkmCollection
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    }).catchError((_) {
      return false;
    });
  }

  Future<Map> inputData(Map data) async {
    try {
      final uid = auth.currentUser!.uid;
      return await umkmCollection
          .doc(uid)
          .set({
            'uid': uid,
            'createdAt': FieldValue.serverTimestamp(),
            'status': false,
            'ktp': data['ktp'],
            'umkm': data['umkm'],
          }, SetOptions(merge: true))
          .then(
            (_) => {
              'status': true,
              'message': 'Berhasil melengkapi data',
            },
          )
          .catchError(
            (_) => {
              'status': false,
              'message': 'Gagal menyimpan data, silakan coba lagi!',
            },
          );
    } catch (_) {
      return {
        'status': false,
        'message': 'Kesalahan tidak diketahui, silakan coba lagi.',
      };
    }
  }
}
