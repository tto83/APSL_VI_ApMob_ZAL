
import 'package:baza_praconikow/data/local/db/app_db.dart';
import 'package:baza_praconikow/widget/custom_date_picker_form_field.dart';
import 'package:baza_praconikow/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import 'package:provider/provider.dart';

class EditEmployeeScreen extends StatefulWidget {

  final int id;

  const EditEmployeeScreen({
    required this.id,
    super.key
    });

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  //late AppDb _db;
  final _formKey = GlobalKey<FormState>();
  late EmployeeData _employeeData;
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? _dateOfBirth;

  @override
  void initState() {
    super.initState();
    //_db = AppDb();
    // _employeeData = _db.getEmployee(widget.id);
    getEmployee();
  }

  @override
  void dispose() {
    //_db.close();
    _employeeNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit employee'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              editEmployee();
            },
            icon: const Icon(Icons.save)
            ),
            IconButton(
            onPressed: () {
              deleteEmployee();
            },
            icon: const Icon(Icons.delete)
            ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
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
              )
            ),
            
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

  void editEmployee() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      final entity = EmployeeCompanion(
      id: drift.Value(widget.id),
      userName: drift.Value(_employeeNameController.text),
      firstName: drift.Value(_firstNameController.text),
      lastName: drift.Value(_lastNameController.text),
      dateOfBirth: drift.Value(_dateOfBirth!),

    );

    Provider.of<AppDb>(context).updateEmployee(entity).then((value) => ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.pink,
        content: Text('Employee updated: $value', style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: const Text('[X]', style: TextStyle(color: Colors.white)))
        ],
      ),
    ));
    }
    
  }

  void deleteEmployee() {
    Provider.of<AppDb>(context).deleteEmployee(widget.id).then((value) => ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.pink,
        content: Text('Employee deleted: $value', style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: const Text('[X]', style: TextStyle(color: Colors.white)))
        ],
      ),
      ),
    );
  }
  

  Future<void> getEmployee() async {
    _employeeData = await Provider.of<AppDb>(context).getEmployee(widget.id);
    _employeeNameController.text = _employeeData.userName;
    _firstNameController.text = _employeeData.firstName;
    _lastNameController.text = _employeeData.lastName;
    _dobController.text = _employeeData.dateOfBirth.toIso8601String();

  }

}