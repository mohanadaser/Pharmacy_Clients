import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddClientsController extends GetxController {
  String selectedValue = "";
  final currentuser = FirebaseAuth.instance.currentUser?.uid;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController goverment = TextEditingController();
  TextEditingController addcompany = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  void onInit() {
    currentuser;
    super.onInit();
  }

  //============اضافة الشركات==================
  void addCompanies() async {
    //final uuid = const Uuid().v4();
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentuser)
          .collection("companies")
          .add({"compid": currentuser, "companyname": addcompany.text});

      Get.snackbar("Success", "تم الحفظ بنجاح",
          backgroundColor: Colors.deepPurple, colorText: Colors.white);

      update();
    } on FirebaseException catch (e) {
      Get.snackbar("faild", e.toString(), colorText: Colors.red);
    }
  }
}
