import 'package:flutter/material.dart';

class CustomDatePickerFormField extends StatelessWidget {

  final TextEditingController _controller;
  final String _txtLabel;
  final VoidCallback _callback;
  
  const CustomDatePickerFormField({
    super.key,
    required TextEditingController controller,
    required String txtLabel,
    required VoidCallback callback
    }) : _controller = controller, _txtLabel = txtLabel, _callback = callback;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(_txtLabel)
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
        return "$_txtLabel cant't be empty";
        }
          return null;
      },
      
      onTap: () => _callback,
      
    );
  }
}