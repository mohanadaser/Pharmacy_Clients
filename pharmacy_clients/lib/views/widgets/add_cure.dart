import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../screens/clients_screen.dart';
import 'components.dart';

class AddCure extends StatefulWidget {
  final String id;
  final String name;
  const AddCure({super.key, required this.id, required this.name});

  @override
  State<AddCure> createState() => _AddCureState();
}

class _AddCureState extends State<AddCure> {
  TextEditingController username = TextEditingController();
  TextEditingController cureBalance = TextEditingController();
  @override
  void initState() {
    username.text = widget.name;
    super.initState();
  }

  @override
  dispose() {
    username.dispose();
    cureBalance.dispose();
    super.dispose();
  }

//==================================Add Cure=================================
  void addCure() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    WriteBatch batch = firestore.batch();
    CollectionReference cures = firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("clients")
        .doc(widget.id)
        .collection("curesMonth");
    DocumentReference updateAmount = firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("clients")
        .doc(widget.id);

    batch.set(cures.doc(), {
      "name": username.text,
      "cureBalance": int.parse(cureBalance.text),
      "date": DateTime.now().toString()
    });
    batch.update(updateAmount,
        {"amount": FieldValue.increment(int.parse(cureBalance.text))});
    await batch.commit().then((_) {
      Get.snackbar("success", "تمت العملية بنجاح",
          backgroundColor: Colors.green, colorText: Colors.white);
    }).catchError((error) {
      Get.snackbar("Error", error.toString());
    });
  }
//====================================================================================
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: HexColor("eeeeee"),
        actions: [
          const Center(
            child: Text(
              " اضافة علاج يومى او شهرى",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomForm(
              text: "",
              type: TextInputType.name,
              name: username,
              readonly: true),
          const SizedBox(
            height: 20,
          ),
          CustomForm(
              text: " قيمة العلاج الشهرى او اليومى ",
              type: TextInputType.number,
              name: cureBalance),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.cancel)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white),
                onPressed: () {
                  addCure();
                  Get.to(() => const ClientsScreen());
                },
                child: const Text(
                  "حفظ",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                )),
          ])
        ],
      ),
    );
  }
}
