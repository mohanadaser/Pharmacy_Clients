import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../controller/clients_controller.dart';
import '../widgets/alertdialog.dart';
import '../widgets/components.dart';
import '../widgets/dropdownlist.dart';

class AddClients extends StatelessWidget {
  const AddClients({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('efeee5'),
        appBar: AppBar(
          backgroundColor: HexColor('efeee5'),
          title: const Text(
            "اضافة عميل جديد",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<AddClientsController>(
          builder: (AddClientsController controller) => SingleChildScrollView(
              child: Container(
            width: Get.width,
            margin: const EdgeInsets.all(10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(children: [
                CustomForm(
                  text: "اسم العميل",
                  type: TextInputType.name,
                  name: controller.name,
                ),
                const SizedBox(height: 10.0),
                CustomForm(
                  text: "رقم الهاتف",
                  formating: [LengthLimitingTextInputFormatter(11)],
                  type: TextInputType.phone,
                  name: controller.phone,
                ),
                const SizedBox(height: 10.0),
                CustomForm(
                    text: "الجهة الحكوميه التابع لها",
                    type: TextInputType.name,
                    name: controller.goverment),
                const SizedBox(height: 10.0),
                CustomForm(
                    text: "رصيد العميل",
                    type: TextInputType.number,
                    name: controller.amount),
                const SizedBox(height: 15.0),
                IconButton(
                    onPressed: () {
                      Get.dialog(
                          Alertdialog(addcompany: controller.addcompany));
                    },
                    icon: const Icon(Icons.add, size: 30)),
                const Text(
                  "اضف شركه",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                const FirebaseDropdownMenuItem(),
                const SizedBox(height: 20.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white),
                    onPressed: () {},
                    child: const Text(
                      "اضافة العميل",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ]),
            ),
          )),
        ));
  }
}
