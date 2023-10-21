import 'package:flutter/material.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add employee'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //TODO
              //funkcja dodania do bazy
            },
            icon: const Icon(Icons.save)
            )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Employee Name')
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Name cant't be empty";
                }
              },
            )
          ],
        ),
      ),
    );
  }
}