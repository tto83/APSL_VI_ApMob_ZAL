import 'package:baza_praconikow/widget/custom_date_picker_form_field.dart';
import 'package:baza_praconikow/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateTime? _dateOfBirth;

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
            CustomDatePickerFormField(controller: _dobController, txtLabel: 'Date of birth', callback: () {
              pickDOB(context);
            }),
            const SizedBox(height: 8.0,),
          ],
        ),
      ),
    );
  }

  Future<void> pickDOB(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(context: context,
      initialDate: _dateOfBirth ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.pink,
            onPrimary: Colors.white,
            onSurface: Colors.black
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child ?? const Text(''),
      )
    );

    if(newDate == null) {
      return;
    }

    setState(() {
      _dateOfBirth = newDate;
      String dob = DateFormat('dd/MM/yyyy').format(newDate);
      _dobController.text = dob;
    });

  }
}