import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddClientsController extends GetxController {
  String selectedValue = "";
  final currentuser = FirebaseAuth.instance.currentUser?.uid;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController goverment = TextEditingController();
  TextEditingController addcompany = TextEditingController();
  TextEditingController amount = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    clearController();
    selectedValue = addcompany.text;
    currentuser;
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    goverment.dispose();
    addcompany.dispose();
    amount.dispose();
    super.dispose();
  }

  //======================validation===============================

  //============اضافة الشركات==================
  void addCompanies(userid) async {
    //final uuid = const Uuid().v4();
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userid)
          .collection("companies")
          .add({"compid": userid, "companyname": addcompany.text});

      // Get.snackbar("Success", "تم الحفظ بنجاح",
      //     backgroundColor: Colors.deepPurple, colorText: Colors.white);

      update();
    } on FirebaseException catch (e) {
      Get.snackbar("faild", e.toString(), colorText: Colors.red);
    }
  }
  //======================Add Clients=================================

  void addClients(userid) async {
    try {
      final number = double.parse(amount.text);
      final curency = NumberFormat.currency(locale: 'ar_EG', symbol: 'ج.م.');
      final formattedCurrency = curency.format(number);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userid)
          .collection("clients")
          .add({
        "name": name.text,
        "phone": phone.text,
        "goverment": goverment.text,
        "amount": formattedCurrency,
        "company": selectedValue,
        "clientid": currentuser
      });
      clearController();
      Get.snackbar("Success", "تم الحفظ بنجاح",
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
      update();
    } catch (e) {
      Get.snackbar("faild", e.toString(), colorText: Colors.red);
    }
  }
  //======================Clear controller=================================

  void clearController() {
    name.clear();
    phone.clear();
    goverment.clear();
    addcompany.clear();
    amount.clear();
    update();
  }
}
