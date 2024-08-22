import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pharmacy_clients/controller/network/independency_injection.dart';
import 'package:pharmacy_clients/views/screens/clients_code.dart';
import 'package:pharmacy_clients/views/screens/login_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DependencyInjection.init();
    return SafeArea(
        child: AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.cyanAccent,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Get.to(() => const ClientsCode());
                      },
                      child: const Text('انا عميل',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Get.to(() => const LoginScreen());
                      },
                      child: const Text('انا صيدلى',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)))
                ],
              ),
              Center(
                  child: Image.asset(
                'assets/images/pharmacy.png',
              )),
            ],
          ),
        ),
      ),
    ));
  }
}
