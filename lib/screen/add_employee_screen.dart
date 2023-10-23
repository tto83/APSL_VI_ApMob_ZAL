import 'package:baza_praconikow/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {

  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

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
            CustomTextFormField(controller: _employeeNameController, txtLabel: 'Employee name',),
            const SizedBox(height: 8.0,),
            CustomTextFormField(controller: _firstNameController, txtLabel: 'First name',),
            const SizedBox(height: 8.0,),
            CustomTextFormField(controller: _lastNameController, txtLabel: 'Last name',),
            const SizedBox(height: 8.0,),
            CustomTextFormField(controller: _dobController, txtLabel: 'Date of birth',),
            const SizedBox(height: 8.0,),
          ],
        ),
      ),
    );
  }
}