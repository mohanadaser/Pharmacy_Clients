import 'package:flutter/material.dart';
import 'package:pharmacy_clients/views/screens/clients_screen.dart';
import 'package:pharmacy_clients/views/screens/debit_clients.dart';

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
    const PageThree(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentpage],
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Page Three'),
    );
  }
}
