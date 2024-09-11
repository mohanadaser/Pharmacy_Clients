import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pharmacy_clients/controller/clients_controller.dart';

import '../widgets/components.dart';

class ClientsCode extends StatelessWidget {
  const ClientsCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            " اعرف رصيدك فى الصيدليه",
            style: TextStyle(
                color: Colors.deepPurple, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.find<AddClientsController>().searchcode.text = "";
              Get.find<AddClientsController>().update();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.deepPurple,
          ),
        ),
        body: GetBuilder<AddClientsController>(
          builder: (AddClientsController controller) => Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              width: double.infinity,
              //height: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 3))
                        ],
                      ),
                      child: CustomForm(
                          // ignore: body_might_complete_normally_nullable, avoid_types_as_parameter_names
                          onchange: (value) {
                            controller.searchcode.text = value!;
                            controller.update();
                          },
                          text: "كود العميل  ",
                          type: TextInputType.number,
                          name: controller.searchcode,
                          sufxicon: const Icon(Icons.search)),
                    ),
                  ),
                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              // .collection("Pharmacists")
                              // .doc(FirebaseAuth.instance.currentUser?.uid)
                              .collectionGroup("clients")
                              .where("guid",
                                  isEqualTo: controller.searchcode.text)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            HexColor("00B2E7"),
                                            HexColor("E064F7"),
                                            HexColor("FF8D6C")
                                          ]),
                                          borderRadius:
                                              BorderRadius.circular(13.0)),
                                      child: Card(
                                        child: ListTile(
                                            leading: const Icon(
                                              Icons.person,
                                              color: Colors.deepPurple,
                                              size: 40,
                                            ),
                                            title: Text(snapshot
                                                .data!.docs[index]['name']),
                                            trailing: Text(
                                                "${snapshot.data!.docs[index]['currentAmount']}",
                                                style: TextStyle(
                                                    color: snapshot.data!
                                                                    .docs[index]
                                                                [
                                                                'currentAmount'] >
                                                            0
                                                        ? Colors.green
                                                        : Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18))),
                                      ),
                                    );
                                  });
                            } else {
                              return const Center(
                                child: Text(
                                  "لاتوجد بيانات",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                          })),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ));
  }
}
