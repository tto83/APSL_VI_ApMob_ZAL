import 'package:baza_praconikow/data/local/db/app_db.dart';
import 'package:flutter/material.dart';

class EmployeeStreamScreen extends StatefulWidget {
  const EmployeeStreamScreen({super.key});

  @override
  State<EmployeeStreamScreen> createState() => _EmployeeStreamScreenState();
}

class _EmployeeStreamScreenState extends State<EmployeeStreamScreen> {

  late AppDb _db;

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
      
      appBar: AppBar(
        title: const Text('Employee stream'),
        centerTitle: true,
      ),
      

      body: FutureBuilder<List<EmployeeData>>(
        future: _db.getEmployees(),
        builder: (context, snapshot) {
          final List<EmployeeData>? employees = snapshot.data;

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (employees != null) {
            return ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];

                return GestureDetector( 
                  onTap:  () {
                    Navigator.pushNamed(context, '/edit_employee', arguments: employee.id);
                  },
                  child: Card(
                  //color: Colors.grey.shade400,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.green,
                      width: 1.2,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      bottomRight: Radius.circular(32.0)
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(employee.id.toString()),
                        Text(employee.userName.toString(), style: const TextStyle(color: Colors.black),),
                        Text(employee.firstName.toString(), style: const TextStyle(color: Colors.black),),
                        Text(employee.lastName.toString(), style: const TextStyle(color: Colors.black),),
                        Text(employee.dateOfBirth.toString(), style: const TextStyle(color: Colors.black),)
                      ],),
                  )
                ),);
              }
              );
          }

          return const Text('Database empty');

        },
      ),
       
    );
  }
}