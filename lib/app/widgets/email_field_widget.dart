import 'package:flutter/material.dart';

class EmailFieldWidget extends StatefulWidget {
  const EmailFieldWidget({
    Key? key,
    this.label = 'Email',
    this.readOnly = false,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  final String label;
  final bool readOnly;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<EmailFieldWidget> createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<EmailFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      readOnly: widget.readOnly,
      autofillHints: const [AutofillHints.email],
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.email),
        labelText: widget.label,
      ),
    );
  }
}
