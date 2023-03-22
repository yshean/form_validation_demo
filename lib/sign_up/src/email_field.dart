// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    required this.isEmailAlreadyRegistered,
    required this.setValue,
    required this.setIsEmailAlreadyRegistered,
    super.key,
  });

  final bool isEmailAlreadyRegistered;
  final ValueSetter<String?> setValue;
  final ValueSetter<bool> setIsEmailAlreadyRegistered;

  RegExp get _emailRegex => RegExp(
        r'^(([\w-]+\.)+[\w-]+|([a-zA-Z]|[\w-]{2,}))@((([0-1]?'
        r'[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.'
        r'([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])'
        r')|([a-zA-Z]+[\w-]+\.)+[a-zA-Z]{2,4})$',
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: 'abc@example.com',
      decoration: InputDecoration(
        labelText: 'Email',
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent),
        ),
        errorText: isEmailAlreadyRegistered
            ? 'Email address is already registered'
            : null,
      ),
      onChanged: (value) {
        // clear submission error of email field
        setIsEmailAlreadyRegistered(false);
      },
      onSaved: (value) {
        // _email = value;
        if (value != null) {
          setValue(value);
        }
      },
      // The validator receives the text that the user has entered
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email address cannot be empty';
        }
        if (!_emailRegex.hasMatch(value)) {
          return 'Email address is not valid';
        }
        return null;
      },
    );
  }
}
