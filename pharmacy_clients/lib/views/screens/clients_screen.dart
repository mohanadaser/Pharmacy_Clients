// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pharmacy_clients/views/screens/add_clients.dart';

import '../../controller/clients_controller.dart';
import '../widgets/components.dart';
import 'login_screen.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('efeee5'),
      appBar: AppBar(
        backgroundColor: HexColor('efeee5'),
        title: const Text(
          "قائمة عملاء الصيدليه",
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Get.offAll(() => const LoginScreen());
          },
          icon: const Icon(Icons.logout),
          color: Colors.red,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<AddClientsController>(
          builder: (AddClientsController controller) => SizedBox(
            width: Get.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomForm(
                      // ignore: body_might_complete_normally_nullable
                      onchange: (Value) {
                        controller.searchClients(Value);
                      },
                      text: "البحث عن عملاء الصيدليه  ",
                      type: TextInputType.name,
                      name: controller.searchname,
                      sufxicon: const Icon(Icons.search)),
                ),
                // SizedBox(
                //   height: Get.height * 0.08,
                // ),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection("clients")
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              backgroundColor: Colors.amber,
                            ));
                          }
                          if (snapshot.hasData) {
                            List<DocumentSnapshot> filteredDocuments =
                                snapshot.data!.docs.where((element) {
                              return element['name']
                                  .contains(controller.searchname.text);
                            }).toList();
                            return ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: filteredDocuments.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) => Card(
                                elevation: 5,
                                child: ListTile(
                                  leading: Image.network(
                                    "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                                    width: 40,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(
                                    "${filteredDocuments[index]['name']}",
                                  ),
                                  subtitle: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            "${filteredDocuments[index]['company']}- ",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: filteredDocuments[index]['phone'],
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold))
                                  ])),
                                  trailing: Text(
                                    "${filteredDocuments[index]['amount']}",
                                    style: TextStyle(
                                        color: filteredDocuments[index]
                                                    ['amount'] >
                                                0
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            );
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(() => const AddClients());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
