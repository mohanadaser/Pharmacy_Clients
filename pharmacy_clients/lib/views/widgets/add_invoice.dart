import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pharmacy_clients/views/widgets/components.dart';
import 'package:pharmacy_clients/views/widgets/navbar.dart';

import '../../controller/clients_controller.dart';
import '../screens/clients_screen.dart';

class AddInvoice extends StatefulWidget {
  final String id;
  final String name;
  const AddInvoice({super.key, required this.id, required this.name});

  @override
  State<AddInvoice> createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  //==============Add Invoice================ ======================================
  void addInvoice() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    WriteBatch batch = firestore.batch();

    CollectionReference invoices = firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("clients")
        .doc(widget.id)
        .collection("invoices");
    DocumentReference updateclient = firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("clients")
        .doc(widget.id);

    batch.set(invoices.doc(), {
      "name": name.text,
      "cureAmount": int.parse(cureAmount.text),
      "date": DateTime.now().toString(),
      "deviceid": Get.find<AddClientsController>().deviceid
    });
    batch.update(updateclient,
        {"currentAmount": FieldValue.increment(-int.parse(cureAmount.text))});
    await batch.commit().then((_) {
      Get.snackbar("success", "تمت العملية بنجاح",
          backgroundColor: Colors.green, colorText: Colors.white);
    }).catchError((error) {
      Get.snackbar("Error", error.toString());
    });
  }

//==================================================================================
  TextEditingController name = TextEditingController();
  TextEditingController cureAmount = TextEditingController();
  @override
  void initState() {
    name.text = widget.name;
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    cureAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: HexColor("eeeeee"),
        actions: [
          const Center(
            child: Text(
              "فاتورة بيع",
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
              text: "", type: TextInputType.name, name: name, readonly: true),
          const SizedBox(
            height: 20,
          ),
          CustomForm(
              text: "قيمة العلاج",
              type: TextInputType.number,
              name: cureAmount),
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
                  addInvoice();
                  Get.to(() => const NavBar());
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
