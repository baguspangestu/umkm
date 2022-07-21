import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:validators/validators.dart';
import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final AuthController authC = Get.find();
  final Rx validateMode = AutovalidateMode.disabled.obs;
  final RxBool formFPass = false.obs;
  final RxBool formLogin = true.obs;
  final RxBool loading = false.obs;
  final RxInt countdown = 0.obs;
  final formKey = GlobalKey<FormState>();
  final dataForm = {
    'email': TextEditingController(),
    'password': TextEditingController(),
    're_password': TextEditingController(),
  };
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  final validator = {}.obs;

  @override
  void onInit() {
    initValidator();
    super.onInit();
  }

  void initValidator() {
    validator.value = {
      'email': (value) {
        if (value.isEmpty) {
          return 'Email wajib diisi!';
        } else if (!isEmail(value)) {
          return 'Masukan email yang benar!';
        }
        return null;
      },
      'password': (value) {
        if (value.isEmpty) {
          return 'Password wajib diisi!';
        } else if (value.length < 6) {
          return 'Password minimal 6 karakter!';
        }
        return null;
      },
      're_password': (value) {
        if (value.isEmpty || value != dataForm['password']?.text) {
          return 'Ulangi password harus sama dengan Password!';
        }
        return null;
      }
    };
  }

  void switchForm() => formLogin.value = !formLogin.value;
  void switchFPas() => formFPass.value = !formFPass.value;

  void setCountdown() {
    countdown.value = 60;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (--countdown.value == 0) timer.cancel();
    });
  }

  void resetButton(bool success) {
    if (success) {
      btnController.success();
      Timer(
        const Duration(milliseconds: 500),
        () => Get.offAllNamed(Routes.home),
      );
    } else {
      btnController.error();
      Timer(const Duration(seconds: 1), () => btnController.reset());
    }
  }

  void sucessDialog(message) {
    btnController.success();
    Get.defaultDialog(
      title: 'Sukses',
      titleStyle: const TextStyle(
        color: Colors.white,
      ),
      middleText: message,
      middleTextStyle: const TextStyle(
        color: Colors.white,
      ),
      backgroundColor: Colors.green,
    ).then((_) => btnController.reset());
  }

  void errorDialog(message) {
    btnController.error();
    Get.defaultDialog(
      title: 'ERROR',
      titleStyle: const TextStyle(
        color: Colors.white,
      ),
      middleText: message,
      middleTextStyle: const TextStyle(
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
    ).then((_) => btnController.reset());
  }

  Future<void> onRegister(data) async {
    final response = await authC.register(data);

    if (response['status']) {
      btnController.success();
      Timer(const Duration(milliseconds: 500), () async {
        btnController.reset();
      });
      await onSendVerif();
    } else {
      errorDialog(response['message']);
    }
  }

  Future<void> onSendVerif() async {
    loading.value = true;
    final response = await authC.sendVerif();

    if (response['status']) {
      setCountdown();
    } else {
      errorDialog(response['message']);
    }
    loading.value = false;
  }

  Future<void> onCheckVerif() async {
    final response = await authC.checkVerif();

    if (response['status']) {
      btnController.success();
      Timer(const Duration(milliseconds: 500), () async {
        Get.offAllNamed(Routes.register);
      });
    } else {
      errorDialog(response['message']);
    }
  }

  Future<void> onLogin(data) async {
    final response = await authC.login(data);

    if (response['status']) {
      if (authC.loggedIn.isTrue) {
        btnController.success();
        Timer(const Duration(milliseconds: 500), () {
          if (authC.verified.isTrue || authC.admin.isTrue) {
            Get.offAllNamed(Routes.home);
          } else {
            authC.sendVerif();
            btnController.reset();
          }
        });
      }
    } else {
      errorDialog(response['message']);
    }
  }

  Future<void> onForgotPassword(data) async {
    final response = await authC.forgotPassword(data);

    if (response['status']) {
      formFPass.value = false;
      setCountdown();
      sucessDialog(response['message']);
      Timer(const Duration(milliseconds: 500), () {
        btnController.reset();
      });
    } else {
      errorDialog(response['message']);
    }
  }

  void onSubmit() {
    validateMode.value = AutovalidateMode.onUserInteraction;
    final isValidForm = formKey.currentState!.validate();
    final data = {
      'email': dataForm['email']?.text.trim(),
      'password': dataForm['password']?.text.trim(),
    };

    if (isValidForm) {
      if (authC.loggedIn.isTrue && authC.verified.isFalse) {
        onCheckVerif();
      } else if (formFPass.isTrue) {
        onForgotPassword(data);
      } else if (formLogin.isTrue) {
        onLogin(data);
      } else {
        onRegister(data);
      }
    } else {
      resetButton(false);
    }
  }
}
