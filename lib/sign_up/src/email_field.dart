// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  const EmailField({
    required this.isEmailAlreadyRegistered,
    required this.setValue,
    required this.setIsEmailAlreadyRegistered,
    super.key,
  });

  final bool isEmailAlreadyRegistered;
  final ValueSetter<String?> setValue;
  final ValueSetter<bool> setIsEmailAlreadyRegistered;

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  // see https://stackoverflow.com/a/742455/14052058 for discussion
  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: 'Email',
        // this is a workaround for async validations
        errorText: widget.isEmailAlreadyRegistered
            ? 'Email address is already registered'
            : null,
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _controller.clear();
                  widget.setValue(null);
                },
                icon: const Icon(Icons.clear),
              )
            : null,
      ),
      onChanged: (value) {
        // clear submission error of email field
        widget.setIsEmailAlreadyRegistered(false);
      },
      onSaved: widget.setValue,
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
      textInputAction: TextInputAction.next,
    );
  }
}
