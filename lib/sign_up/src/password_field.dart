// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    required this.setValue,
    super.key,
  });

  final void Function(String?) setValue;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: _obscureText
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
      ),
      obscureText: _obscureText,
      onChanged: widget.setValue,
      onSaved: widget.setValue,
      // The validator receives the text that the user has entered
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty';
        }
        if (value.length < 5) {
          return 'Password is too short';
        }
        if (value.length > 120) {
          return 'Password is too long';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      // to fix TextInputAction.next not working when there is a suffixIcon
      // https://www.reddit.com/r/flutterhelp/comments/xl9jrx/comment/ipo9zd2/
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
    );
  }
}
