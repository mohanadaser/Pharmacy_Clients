// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pharmacy_clients/views/screens/edit_clients.dart';

import '../../controller/clients_controller.dart';

import '../widgets/components.dart';

import 'login_screen.dart';

class CodesClients extends StatefulWidget {
  const CodesClients({super.key});

  @override
  State<CodesClients> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<CodesClients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "اكواد عملاء الصيدليه",
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
                        //controller.searchClients(Value);
                        controller.searchname.text == Value;
                        controller.update();
                      },
                      text: "البحث",
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
                            .collection("Pharmacists")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection("clients")
                            .orderBy("name")
                            .startAt([controller.searchname.text]).endAt([
                          "${controller.searchname.text}\uf8ff"
                        ]).snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              backgroundColor: Colors.deepPurple,
                            ));
                          }
                          if (snapshot.hasData) {
                            // List<DocumentSnapshot> filteredDocuments =
                            //     snapshot.data!.docs.where((element) {
                            //   return element['name']
                            //       .contains(controller.searchname.text);
                            // }).toList();
                            return ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
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
                                    "${snapshot.data!.docs[index]['name']}",
                                  ),
                                  trailing: Text(
                                    "${snapshot.data!.docs[index]['guid']}",
                                    style: TextStyle(
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
    );
  }
}
