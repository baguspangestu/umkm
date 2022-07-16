import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/myumkm_controller.dart';

class MyumkmView extends GetView<MyumkmController> {
  const MyumkmView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyumkmView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyumkmView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
