import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pharmacy_clients/views/screens/clients_screen.dart';
import 'package:pharmacy_clients/views/screens/debit_clients.dart';

import 'support_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentpage = 0;
  final List<Widget> pages = [
    const ClientsScreen(),
    const DebitClients(),
    const SupportScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: pages[currentpage],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: HexColor("191919"),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          type: BottomNavigationBarType.fixed,
          currentIndex: currentpage,
          onTap: (value) {
            setState(() {
              currentpage = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'عملاء الصيدليه'),
            BottomNavigationBarItem(
                icon: Icon(Icons.money), label: 'مديونية العملاء'),
            BottomNavigationBarItem(
                icon: Icon(Icons.support_agent_rounded),
                label: 'للشكاوى والدعم الفنى'),
          ],
        ),
      ),
    );
  }
}
