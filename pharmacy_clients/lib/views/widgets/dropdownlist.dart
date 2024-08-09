import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_clients/controller/clients_controller.dart';

class FirebaseDropdownMenuItem extends StatefulWidget {
  const FirebaseDropdownMenuItem({super.key});

  @override
  State<FirebaseDropdownMenuItem> createState() =>
      _FirebaseDropdownMenuItemState();
}

class _FirebaseDropdownMenuItemState extends State<FirebaseDropdownMenuItem> {
  @override
  Widget build(BuildContext context) {
    AddClientsController controller = Get.put(AddClientsController());
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(controller.currentuser)
            .collection("companies")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Some error occured ${snapshot.error}"),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Some error occured ${snapshot.error}"),
            );
          } else {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return DropdownButton(
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(12),
              dropdownColor: Colors.white,
              value: controller.selectedValue.isNotEmpty
                  ? controller.selectedValue
                  : null,
              isExpanded: false,
              hint: const Text("اختر اسم الشركه"),
              items: snapshot.data!.docs
                  .map((e) => DropdownMenuItem<String>(
                      value: e['compid'], child: Text(e['companyname'])))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  controller.selectedValue = value.toString();
                });
              },
            );
          }
        });
  }
}
