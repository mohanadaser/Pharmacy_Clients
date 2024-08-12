import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_clients/controller/clients_controller.dart';

import '../widgets/components.dart';

class EditClients extends StatefulWidget {
  final String id;
  final String name;
  final String phone;
  final String company;
  final String goverment;
  final String amount;

  const EditClients(
      {super.key,
      required this.id,
      required this.name,
      required this.phone,
      required this.company,
      required this.goverment,
      required this.amount});

  @override
  State<EditClients> createState() => _EditClientsState();
}

class _EditClientsState extends State<EditClients> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController governorate = TextEditingController();
  TextEditingController amount = TextEditingController();
  @override
  void initState() {
    name.text = widget.name;
    phone.text = widget.phone;
    company.text = widget.company;
    governorate.text = widget.goverment;
    amount.text = widget.amount;
    super.initState();
  }

  @override
  dispose() {
    name.dispose();
    phone.dispose();
    company.dispose();
    governorate.dispose();
    amount.dispose();
    super.dispose();
  }

  void updateClients() async {
    try {
      if (name.text == "") {
        name.text = widget.name;
      }
      if (phone.text == "") {
        phone.text = widget.phone;
      }
      if (company.text == "") {
        company.text = widget.company;
      }
      if (governorate.text == "") {
        governorate.text = widget.goverment;
      }
      if (amount.text == "") {
        amount.text = widget.amount;
      }
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("clients")
          .doc(widget.id)
          .update({
        "name": name.text,
        "phone": phone.text,
        "company": company.text,
        "goverment": governorate.text,
        "amount": amount.text
      });
      Get.snackbar("Success", "تم التعديل بنجاح",
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
    } on FirebaseException catch (e) {
      Get.snackbar("faild", e.toString(), colorText: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل العميل",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple)),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Container(
              width: Get.width,
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  type: TextInputType.name,
                  text: "",
                  name: name,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  type: TextInputType.phone,
                  text: " ",
                  name: phone,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  type: TextInputType.name,
                  text: " ",
                  name: company,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  type: TextInputType.name,
                  text: " ",
                  name: governorate,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomForm(
                  type: TextInputType.number,
                  text: "",
                  name: amount,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      updateClients();
                      Get.back();
                    },
                    child: const Text(
                      "تعديل العميل",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "فاتورة بيع",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      " اضافة علاج يومى او شهرى",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              ])),
        ),
      ),
    );
  }
}
