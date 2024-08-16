import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClientTransactions extends StatefulWidget {
  final String id;
  const ClientTransactions({super.key, required this.id});

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Text(
                      "البحث عن حركات العملاء",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: CustomForm(
                    //       // ignore: body_might_complete_normally_nullable
                    //       onchange: (Value) {
                    //         //controller.searchClients(Value);
                    //         setState(() {
                    //           name.text = Value!;
                    //         });
                    //       },
                    //       text: "البحث عن عملاء الصيدليه  ",
                    //       type: TextInputType.name,
                    //       name: name,
                    //       sufxicon: const Icon(Icons.search)),
                    // ),
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
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    size: 30,
                                  ),
                                ),
                                const Text(" From ")
                              ],
                            ),
                            Text(firstDate == null
                                ? ""
                                : "${firstDate?.day}/${firstDate?.month}/${firstDate?.year}"),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Text("To "),
                                IconButton(
                                  onPressed: pickSecDate,
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            Text(secDate == null
                                ? " "
                                : "${secDate?.day}/${secDate?.month}/${secDate?.year}"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: firstDate != null && secDate != null
                              ? FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("clients")
                                  .doc(widget.id)
                                  .collection("invoices")
                                  .where("date",
                                      isGreaterThanOrEqualTo:
                                          "${firstDate?.day}/${firstDate?.month}/${firstDate?.year}")
                                  .where("date",
                                      isLessThanOrEqualTo:
                                          "${secDate?.day}/${secDate?.month}/${secDate?.year}")
                                  // .startAt([name.text])
                                  // .endAt(["${name.text}\uf8ff"])

                                  .snapshots()
                              : FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("clients")
                                  .doc(widget.id)
                                  .collection("invoices")
                                  .orderBy("date", descending: true)
                                  .snapshots(),

                          //.orderBy("date", descending: true)

                          // .where("date",
                          //     isGreaterThanOrEqualTo: firstDate.toString())
                          // .where("date",
                          //     isLessThanOrEqualTo: secDate.toString())
                          // .where("date" == secDate.toString())

                          // : FirebaseFirestore.instance
                          //     .collectionGroup("invoices")
                          //     .where("uid",
                          //         isEqualTo: FirebaseAuth
                          //             .instance.currentUser!.uid
                          //             .toString())

                          //     //.orderBy("date", descending: true)
                          //     .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: Colors.deepPurple,
                              ));
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                    "Some error occured ${snapshot.error}"),
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
                                          shadowColor: Colors.deepPurple,
                                          elevation: 7,
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
                                                      "${snapshot.data!.docs[index]['type']} ",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: snapshot.data!
                                                      .docs[index]['date'],
                                                  style: const TextStyle(
                                                      color: Colors.deepPurple,
                                                      fontWeight:
                                                          FontWeight.bold))
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
                          }),
                    )
                  ],
                )),
          )),
    );
  }
}
