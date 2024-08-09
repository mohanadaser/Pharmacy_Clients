// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/clients_controller.dart';

class Alertdialog extends StatelessWidget {
  final addcompany;

  const Alertdialog({
    super.key,
    required this.addcompany,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddClientsController>(
      builder: (AddClientsController controller) => AlertDialog(
        actions: [
          TextField(
            controller: addcompany,
            decoration: InputDecoration(
                hintText: "اسم الشركه",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    controller.addCompanies();
                    Get.back();
                  },
                  child: const Text(
                    "اضافة الشركه",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  )),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.cancel))
            ],
          ),
        ],
      ),
    );
  }
}
