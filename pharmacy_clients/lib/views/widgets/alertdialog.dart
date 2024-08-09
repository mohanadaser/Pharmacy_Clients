import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Alertdialog extends StatelessWidget {
  const Alertdialog({
    super.key,
    required this.addcompany,
  });

  final TextEditingController addcompany;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                  //controller.addCompanies();
                  Get.back();
                },
                child: const Text(
                  "اضافة الشركه",
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                )),
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.cancel))
          ],
        ),
      ],
    );
  }
}