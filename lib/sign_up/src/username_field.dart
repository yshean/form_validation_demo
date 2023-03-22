// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({
    required this.isUsernameAlreadyTaken,
    required this.setValue,
    required this.setIsUsernameAlreadyTaken,
    super.key,
  });

  final bool isUsernameAlreadyTaken;
  final void Function(String?) setValue;
  final void Function(bool) setIsUsernameAlreadyTaken;

  RegExp get _usernameRegex => RegExp(
        r'^(?=.{1,20}$)(?![_])(?!.*[_.]{2})[a-zA-Z0-9_]+(?<![_])$',
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Username',
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent),
        ),
        // this is a workaround for async validations
        errorText: isUsernameAlreadyTaken ? 'Username is already taken' : null,
      ),
      onChanged: (value) {
        // clear submission error of username field
        setIsUsernameAlreadyTaken(false);
      },
      onSaved: (value) {
        if (value != null) {
          setValue(value);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Username cannot be empty';
        }
        if (!_usernameRegex.hasMatch(value)) {
          return 'Username is not valid';
        }
        return null;
      },
    );
  }
}
