import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});
  //===============================تحميل وتشغيل الواتساب=============================
  void launchWhatsapp(
    String phone,
    String message,
  ) async {
    final url = 'https://wa.me/+20$phone?text=$message';

    await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

//==============================================================================

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              HexColor("360033"),
              HexColor("0b8793"),
            ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "يمكنكم التواصل معنا لتلقى الشكاوى والاستفسارات\nوتقديم كافة الخدمات والدعم الفنى لكم وذلك من خلال رقم الواتس",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    launchUrlString('https://wa.me/+201556997194');
                  },
                  child: Image.asset(
                    "assets/images/watsapp.png",
                    width: 50,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "اضغط هنا",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
