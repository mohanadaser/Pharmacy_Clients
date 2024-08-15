import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'components.dart';

class ClientTransactions extends StatefulWidget {
  const ClientTransactions({super.key});

  @override
  State<ClientTransactions> createState() => _ClientTransactionsState();
}

class _ClientTransactionsState extends State<ClientTransactions> {
  DateTime? firstDate;
  DateTime? secDate;
  TextEditingController name = TextEditingController();
  Future pickFirstDate() async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: firstDate ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 20),
      lastDate: DateTime.now(),
    );
    if (newDate == null) {
      return;
    }
    setState(() => firstDate = newDate);
  }

  Future pickSecDate() async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: secDate ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime.now(),
    );
    if (newDate == null) {
      return;
    }
    setState(() => secDate = newDate);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Text(
                    "البحث عن حركات العملاء",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: pickFirstDate,
                                icon: const Icon(Icons.calendar_today),
                              ),
                              const Text(" من تاريخ")
                            ],
                          ),
                          Text(
                              "${firstDate?.day}/${firstDate?.month}/${firstDate?.year}"),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text("الى تاريخ"),
                              IconButton(
                                onPressed: pickSecDate,
                                icon: const Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                          Text(
                              "${secDate?.day}/${secDate?.month}/${secDate?.year}"),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  StreamBuilder<QuerySnapshot>(
                      stream: firstDate != null && secDate != null
                          ? FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("clients")
                              .doc()
                              .collection("invoices")
                              .orderBy("date", descending: true)
                              .where("date",
                                  isGreaterThanOrEqualTo: firstDate,
                                  isLessThanOrEqualTo: secDate)
                              //.where("date", isLessThanOrEqualTo: secDate)
                              .snapshots()
                          : FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("clients")
                              .doc()
                              .collection("invoices")
                              .orderBy("date", descending: true)
                              .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                            backgroundColor: Colors.deepPurple,
                          ));
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Some error occured ${snapshot.error}"),
                          );
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
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
                                        subtitle: RichText(
                                            text: TextSpan(children: [
                                          TextSpan(
                                              text:
                                                  "${snapshot.data!.docs[index]['type']}- ",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text: snapshot.data!.docs[index]
                                                  ['date'],
                                              style: const TextStyle(
                                                  color: Colors.deepPurple,
                                                  fontWeight: FontWeight.bold))
                                        ])),
                                        trailing: Text(
                                          "${snapshot.data!.docs[index]['cureAmount']}",
                                          style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ));
                              });
                        }
                      })
                ],
              )),
        ),
      )),
    );
  }
}
