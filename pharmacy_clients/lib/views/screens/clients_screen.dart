import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "قائمة المنتجات",
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Get.offAll(() => const LoginScreen());
          },
          icon: const Icon(Icons.logout),
          color: Colors.red,
        ),
      ),
    );
  }
}
