// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

import 'sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    required this.userRepository,
    required this.onSignUpSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final void Function(String) onSignUpSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SignUpForm(
            userRepository: userRepository,
            onSignUpSuccess: onSignUpSuccess,
          ),
        ),
      ),
    );
  }
}
