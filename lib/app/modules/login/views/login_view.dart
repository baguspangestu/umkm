import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:umkm/app/widgets/email_field_widget.dart';
import '../../../widgets/password_field_widget.dart';
import '../controllers/login_controller.dart';

const users = {
  'baguspangestu44@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: Get.size.height,
      color: Get.theme.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Obx(
                  () => Form(
                    autovalidateMode: controller.validateMode.value,
                    key: controller.formKey,
                    child: AutofillGroup(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.authC.loggedIn.isTrue &&
                                      controller.authC.verified.isFalse &&
                                      controller.authC.admin.isFalse
                                  ? 'Verifikasi Email'
                                  : controller.formLogin.isTrue
                                      ? 'Masuk Akun'
                                      : 'Pendaftaran',
                              style: const TextStyle(fontSize: 24),
                            ),
                            const Divider(),
                            Visibility(
                              visible: controller.authC.loggedIn.isTrue &&
                                  controller.authC.verified.isFalse &&
                                  controller.authC.admin.isFalse,
                              replacement: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  EmailFieldWidget(
                                    controller: controller.dataForm['email']!,
                                    validator: controller.validator['email']!,
                                  ),
                                  const SizedBox(height: 16),
                                  PasswordFieldWidget(
                                    controller:
                                        controller.dataForm['password']!,
                                    validator:
                                        controller.validator['password']!,
                                  ),
                                  const SizedBox(height: 16),
                                  Visibility(
                                    visible: controller.formLogin.isTrue,
                                    replacement: PasswordFieldWidget(
                                      label: 'Ulangi Password',
                                      autoFillHints: null,
                                      controller:
                                          controller.dataForm['re_password']!,
                                      validator:
                                          controller.validator['re_password']!,
                                    ),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: InkWell(
                                        onTap: controller.forgotPassword,
                                        child: Text('Lupa Password?',
                                            style: TextStyle(
                                                color: Get.theme.buttonTheme
                                                    .colorScheme?.primary)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Link verifikasi telah dikirim ke email kamu, silakan periksa folder spam jika tidak ada.',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          color: Colors.white70,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                    controller.authC.auth
                                                            .currentUser?.email
                                                            ?.toString() ??
                                                        'loading...',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(8),
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 14,
                                                    color: Get.theme.buttonTheme
                                                        .colorScheme?.primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Material(
                                        color: Get.theme.buttonTheme.colorScheme
                                            ?.primary,
                                        elevation: 1,
                                        borderRadius: BorderRadius.circular(4),
                                        child: InkWell(
                                          onTap: () {},
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              'Kirim Ulang',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Jika sudah diverifikasi silakan klik tombol masuk.',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            RoundedLoadingButton(
                              controller: controller.btnController,
                              onPressed: controller.submit,
                              color: Get.theme.buttonTheme.colorScheme?.primary,
                              child: Text(
                                (controller.authC.loggedIn.isTrue &&
                                            controller.authC.verified.isFalse &&
                                            controller.authC.admin.isFalse) ||
                                        controller.formLogin.isTrue
                                    ? 'MASUK'
                                    : 'DAFTAR',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Visibility(
                              visible: controller.authC.loggedIn.isFalse,
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  InkWell(
                                    onTap: controller.switchForm,
                                    child: Text(
                                      controller.formLogin.value
                                          ? 'DAFTAR'
                                          : 'MASUK',
                                      style: TextStyle(
                                          color: Get.theme.buttonTheme
                                              .colorScheme?.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: Text(
                'App v1.0.0',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Center(
              child: Text(
                'UMKM KABUPATEN PRINGSEWU',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Center(
              child: Text(
                '@2022 Kentas Adi Saputra',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
