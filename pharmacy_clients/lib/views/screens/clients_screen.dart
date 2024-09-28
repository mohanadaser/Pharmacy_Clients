// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names, prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pharmacy_clients/views/screens/add_clients.dart';
import 'package:pharmacy_clients/views/screens/client_transactions.dart';
import 'package:pharmacy_clients/views/screens/edit_clients.dart';

import '../../controller/clients_controller.dart';

import '../widgets/add_invoice.dart';
import '../widgets/components.dart';

import 'login_screen.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "قائمة عملاء الصيدليه",
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await FirebaseAuth.instance.currentUser?.delete();

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
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Pharmacists")
                    .where("uid",
                        isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                    .snapshots(),
                builder: (context, snap) {
                  return Column(
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
                                  .collection("Pharmacists")
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .collection("clients")
                                  .orderBy("name")
                                  .startAt([controller.searchname.text]).endAt([
                                "${controller.searchname.text}\uf8ff"
                              ]).snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                    itemBuilder: (context, index) => InkWell(
                                      //======================================edit clients=========
                                      // onTap: () {
                                      //   Get.to(() => EditClients(
                                      //         id: snapshot.data!.docs[index].id,
                                      //         name: snapshot.data!.docs[index]
                                      //             ['name'],
                                      //         company: snapshot
                                      //             .data!.docs[index]['company'],
                                      //         phone: snapshot.data!.docs[index]
                                      //             ['phone'],
                                      //         amount: snapshot.data!.docs[index]
                                      //             ['currentAmount'],
                                      //         goverment: snapshot.data!
                                      //             .docs[index]['goverment'],
                                      //       ));
                                      // },
                                      //=========================================delete clients=========
                                      // onLongPress: () {
                                      //   AwesomeDialog(
                                      //     context: context,
                                      //     dialogType: DialogType.warning,
                                      //     animType: AnimType.bottomSlide,
                                      //     title: 'تنبيه',
                                      //     desc: 'هل تريد حذف هذا العميل؟',
                                      //     btnCancelOnPress: () {
                                      //       Get.back();
                                      //     },
                                      //     btnOkOnPress: () {
                                      //       controller.deleteClients(
                                      //           snapshot.data!.docs[index].id,
                                      //           snap.data!.docs[0]['uid']);
                                      //     },
                                      //     buttonsTextStyle: const TextStyle(
                                      //         color: Colors.white),
                                      //     showCloseIcon: true,
                                      //   ).show();
                                      // },
                                      //==============================================================
                                      child: Card(
                                        color: Colors.deepPurple,
                                        elevation: 5,
                                        child: ListTile(
                                          leading: PopupMenuButton(
                                              icon: const Icon(
                                                  Icons.more_vert,
                                                  color: Colors.white),
                                              itemBuilder: (context) => [
                                                    const PopupMenuItem(
                                                      value: 1,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "تعديل",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Icon(
                                                            Icons.edit,
                                                            color: Colors
                                                                .deepPurple,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const PopupMenuItem(
                                                      value: 2,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("حذف",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Icon(
                                                            Icons
                                                                .delete_outline,
                                                            color: Colors.red,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const PopupMenuItem(
                                                      value: 3,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "اضافة فاتورة بيع او رصيد علاج",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Icon(
                                                            Icons.add,
                                                            color:
                                                                Colors.green,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const PopupMenuItem(
                                                      value: 4,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "عرض حركات العميل",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          Icon(
                                                            Icons
                                                                .list_alt_outlined,
                                                            color:
                                                                Colors.orange,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                              onSelected: (value) {
                                                if (value == 1) {
                                                  Get.to(() => EditClients(
                                                      id: snapshot.data!
                                                          .docs[index].id,
                                                      name: snapshot.data!.docs[index]
                                                          ['name'],
                                                      company: snapshot.data!
                                                              .docs[index]
                                                          ['company'],
                                                      phone: snapshot.data!.docs[index]
                                                          ['phone'],
                                                      amount: snapshot.data!
                                                              .docs[index]
                                                          ['currentAmount'],
                                                      goverment: snapshot
                                                              .data!
                                                              .docs[index]
                                                          ['goverment']));
                                                } else if (value == 2) {
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.warning,
                                                    animType:
                                                        AnimType.bottomSlide,
                                                    title: 'تنبيه',
                                                    desc:
                                                        'هل تريد حذف هذا العميل؟',
                                                    btnCancelOnPress: () {
                                                      Get.back();
                                                    },
                                                    btnOkOnPress: () {
                                                      controller
                                                          .deleteClients(
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id,
                                                              snap.data!
                                                                      .docs[0]
                                                                  ['uid']);
                                                    },
                                                    buttonsTextStyle:
                                                        const TextStyle(
                                                            color:
                                                                Colors.white),
                                                    showCloseIcon: true,
                                                  ).show();
                                                } else if (value == 3) {
                                                  Get.dialog(AddInvoice(
                                                      id: snapshot.data!
                                                          .docs[index].id,
                                                      name: snapshot.data!
                                                              .docs[index]
                                                          ['name']));
                                                }
                                          
                                                if (value == 4) {
                                                  Get.to(() =>
                                                      ClientTransactions(
                                                          id: snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id));
                                                }
                                              }),
                                          title: Text(
                                            "${snapshot.data!.docs[index]['name']}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    "${snapshot.data!.docs[index]['company']}- ",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    "${snapshot.data!.docs[index]['guid']} - ",
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: snapshot.data!.docs[index]
                                                    ['phone'],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ])),
                                          trailing: Text(
                                            "${snapshot.data!.docs[index]['currentAmount']}",
                                            style: TextStyle(
                                                color: snapshot.data!
                                                                .docs[index]
                                                            ['currentAmount'] >
                                                        0
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
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
                  );
                }),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
