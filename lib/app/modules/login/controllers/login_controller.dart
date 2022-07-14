import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:validators/validators.dart';
import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final AuthController authC = Get.find();
  final validateMode = AutovalidateMode.disabled.obs;
  final formLogin = true.obs;
  final formKey = GlobalKey<FormState>();
  final dataForm = {
    'email': TextEditingController(),
    'password': TextEditingController(),
    're_password': TextEditingController(),
  };
  final focus = FocusNode();
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

  void resetButton(bool success) {
    if (success) {
      btnController.success();
      Timer(const Duration(milliseconds: 500),
          () => Get.offAllNamed(Routes.home));
    } else {
      btnController.error();
      Timer(const Duration(seconds: 1), () => btnController.reset());
    }
  }

  void errorDialog(message) {
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

  Future<void> register(data) async {
    final response = await authC.register(data);

    if (response['status']) {
      authC.sendVerif();
      btnController.success();
      Timer(const Duration(seconds: 1), () async {
        await authC.isAuth();
        btnController.reset();
      });
    } else {
      btnController.error();
      errorDialog(response['message']);
    }
  }

  Future<void> checkVerif() async {
    final response = await authC.checkVerif();

    if (response['status']) {
      btnController.success();
      Timer(
        const Duration(seconds: 1),
        () => Get.offAllNamed(Routes.home),
      );
    } else {
      btnController.error();
      errorDialog(response['message']);
    }
  }

  Future<void> login(data) async {
    final response = await authC.login(data);

    if (response['status']) {
      if (authC.loggedin.isTrue) {
        Timer(const Duration(milliseconds: 500), () {
          if (authC.verified.isTrue) Get.offAllNamed(Routes.home);
        });
      }
    } else {
      btnController.error();
      errorDialog(response['message']);
    }
  }

  Future<void> forgotPassword() async {
    await authC.auth.sendPasswordResetEmail(email: 'baguspangestu44@gmail.com');
  }

  void submit() {
    validateMode.value = AutovalidateMode.onUserInteraction;
    final isValidForm = formKey.currentState!.validate();
    final data = {
      'email': dataForm['email']?.text,
      'password': dataForm['password']?.text,
    };

    if (isValidForm) {
      if (authC.loggedin.isTrue && authC.verified.isFalse) {
        checkVerif();
      } else {
        if (formLogin.value) {
          login(data);
        } else {
          register(data);
        }
      }
    } else {
      resetButton(false);
    }
  }
}
