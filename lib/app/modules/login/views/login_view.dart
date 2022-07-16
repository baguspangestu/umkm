import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:umkm/app/widgets/email_field_widget.dart';
import '../../../config/config.dart';
import '../../../widgets/password_field_widget.dart';
import '../controllers/login_controller.dart';

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
                                  : controller.formFPass.isTrue
                                      ? 'Lupa Password'
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
                                  Visibility(
                                    visible: controller.formFPass.isFalse,
                                    child: Column(
                                      children: [
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
                                            controller: controller
                                                .dataForm['re_password']!,
                                            validator: controller
                                                .validator['re_password']!,
                                          ),
                                          child: Container(
                                            alignment: Alignment.topLeft,
                                            child: InkWell(
                                              onTap: controller.switchFPas,
                                              child: Text(
                                                'Lupa Password?',
                                                style: TextStyle(
                                                    color: Get.theme.buttonTheme
                                                        .colorScheme!.primary),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
                                                onTap: () {
                                                  final snackBar = SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: const Text(
                                                        'Fitur ini belum tersedia saat ini.'),
                                                    action: SnackBarAction(
                                                      label: 'Oke',
                                                      onPressed: () {},
                                                    ),
                                                  );

                                                  Get.snackbar(
                                                    'Informasi',
                                                    'Fitur ini belum tersedia saat ini.',
                                                  );

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                },
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
                                        color:
                                            controller.countdown.value == 0 &&
                                                    controller.loading.isFalse
                                                ? Get.theme.buttonTheme
                                                    .colorScheme?.primary
                                                : Colors.grey,
                                        elevation: 1,
                                        borderRadius: BorderRadius.circular(4),
                                        child: InkWell(
                                          onTap:
                                              controller.countdown.value == 0 &&
                                                      controller.loading.isFalse
                                                  ? controller.onSendVerif
                                                  : null,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Visibility(
                                              visible:
                                                  controller.loading.isTrue,
                                              replacement: Visibility(
                                                visible: controller
                                                        .countdown.value ==
                                                    60,
                                                replacement: Text(
                                                  controller.countdown.value ==
                                                          0
                                                      ? 'Kirim Ulang'
                                                      : '${controller.countdown.value}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                child: const Icon(
                                                  Icons.check,
                                                  size: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              child: SizedBox(
                                                width: 14,
                                                height: 14,
                                                child: Transform.scale(
                                                  scale: 0.5,
                                                  child:
                                                      const CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                ),
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
                              onPressed: controller.formFPass.isTrue &&
                                      controller.countdown.value != 0
                                  ? null
                                  : controller.onSubmit,
                              color: Get.theme.buttonTheme.colorScheme?.primary,
                              child: Text(
                                controller.authC.loggedIn.isTrue &&
                                        controller.authC.verified.isFalse &&
                                        controller.authC.admin.isFalse
                                    ? 'MASUK'
                                    : controller.formFPass.isTrue &&
                                            controller.countdown.value != 0
                                        ? '${controller.countdown.value}'
                                        : controller.formFPass.isTrue
                                            ? 'RESET PASSWORD'
                                            : controller.formLogin.isTrue
                                                ? 'MASUK'
                                                : 'DAFTAR',
                                style: TextStyle(
                                  color: controller.formFPass.isTrue &&
                                          controller.countdown.value != 0
                                      ? Get.theme.buttonTheme.colorScheme
                                          ?.primary
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: controller.authC.loggedIn.isFalse,
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  InkWell(
                                    onTap: controller.formFPass.isTrue
                                        ? controller.switchFPas
                                        : controller.switchForm,
                                    child: Text(
                                      controller.formFPass.isTrue
                                          ? 'MASUK'
                                          : controller.formLogin.isTrue
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
            Center(
              child: Text(
                'App v${Config.app.version}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                Config.app.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                '${Config.app.copyright} - ${Config.app.developer}',
                style: const TextStyle(
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
