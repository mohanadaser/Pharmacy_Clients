import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pharmacy_clients/views/widgets/components.dart';

import '../screens/clients_screen.dart';

class AddInvoice extends StatefulWidget {
  final String id;
  final String name;
  const AddInvoice({super.key, required this.id, required this.name});

  @override
  State<AddInvoice> createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
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
      "date": DateTime.now().toString()
    });
    batch.update(updateclient,
        {"amount": FieldValue.increment(-int.parse(cureAmount.text))});
    await batch.commit().then((_) {
      Get.snackbar("success", "تمت العملية بنجاح");
    }).catchError((error) {
      Get.snackbar("Error", error.toString());
    });
  }

  TextEditingController name = TextEditingController();
  TextEditingController cureAmount = TextEditingController();
  @override
  void initState() {
    name.text = widget.name;
    super.initState();
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
          CustomForm(
              text: "", type: TextInputType.name, name: name, readonly: true),
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
