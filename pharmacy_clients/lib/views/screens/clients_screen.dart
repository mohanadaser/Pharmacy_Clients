import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pharmacy_clients/views/screens/add_clients.dart';

import '../widgets/components.dart';
import 'login_screen.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomForm(
                  onchange: (Value) {
                    return null;
                  },
                  text: "البحث عن عملاء الصيدليه  ",
                  type: TextInputType.name,
                  name: name,
                  sufxicon: const Icon(Icons.search)),
            ),
            // SizedBox(
            //   height: Get.height * 0.08,
            // ),
            Expanded(
                child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 20,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) => ListTile(
                leading: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                  width: 40,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: const Text("عبدالله محمد محمود"),
                subtitle: RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "شركة النيل",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "-  01016305422",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold))
                ])),
                trailing: const Text(
                  "6000",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            )),
          ],
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
