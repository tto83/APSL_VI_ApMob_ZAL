import 'package:baza_praconikow/data/local/db/app_db.dart';
import 'package:baza_praconikow/screen/employee_future.dart';
import 'package:baza_praconikow/screen/employee_stream.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late AppDb _db;
  int index = 0;

  final pages = const [
    EmployeeFutureScreen(),
    EmployeeStreamScreen()
  ];

  @override
  void initState() {
    super.initState();
    _db = AppDb();
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      */

      body: pages[index],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add_employee');
        },
        icon: const Icon(Icons.add),
        label: const Text('Add employee')),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          backgroundColor: Colors.blue.shade300,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white30,
          showSelectedLabels: false,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              activeIcon: Icon(Icons.list_outlined),
              label: 'Employee Future'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              activeIcon: Icon(Icons.list_outlined),
              label: 'Employee Stream'
            ),
          ],
          ),
    );
  }
}