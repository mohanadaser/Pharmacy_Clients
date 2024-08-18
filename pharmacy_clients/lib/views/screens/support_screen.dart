import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            HexColor("00B2E7"),
            HexColor("E064F7"),
            HexColor("FF8D6C")
          ])),
      child: const Column(
        children: [],
      ),
    );
  }
}
