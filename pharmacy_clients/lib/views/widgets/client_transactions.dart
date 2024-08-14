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
                      Row(
                        children: [
                          // Text(
                          //     "${firstDate?.day}/${firstDate?.month}/${firstDate?.year}"),
                          IconButton(
                            onPressed: pickFirstDate,
                            icon: const Icon(Icons.calendar_today),
                          ),
                          const Text("من")
                        ],
                      ),
                      Row(
                        children: [
                          // Text(
                          //     "${secDate?.day}/${secDate?.month}/${secDate?.year}"),
                          const Text("الى"),
                          IconButton(
                            onPressed: pickSecDate,
                            icon: const Icon(Icons.calendar_today),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ),
      )),
    );
  }
}
