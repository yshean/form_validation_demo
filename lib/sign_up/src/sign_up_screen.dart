// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

import 'confirm_password_field.dart';
import 'email_field.dart';
import 'password_field.dart';
import 'sign_up_submit_button.dart';
import 'username_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    required this.userRepository,
    required this.onSignUpSuccess,
    required this.showSnackbar,
    super.key,
  });

  final UserRepository userRepository;
  final void Function(String) onSignUpSuccess;
  final void Function(String) showSnackbar;

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
            showSnackbar: showSnackbar,
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    required this.userRepository,
    required this.onSignUpSuccess,
    required this.showSnackbar,
    super.key,
  });

  final UserRepository userRepository;
  final void Function(String) onSignUpSuccess;
  final void Function(String) showSnackbar;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a `GlobalKey<SignUpBasicFormState>`.
  final _formKey = GlobalKey<FormState>();

  // To keep track of field errors
  bool _isEmailAlreadyRegistered = false;
  bool _isUsernameAlreadyTaken = false;
  bool get _hasAsyncErrors =>
      _isEmailAlreadyRegistered || _isUsernameAlreadyTaken;

  // Form is dirty when it has been submitted at least once
  bool _isFormDirty = false;

  // To keep track of form states
  bool _isSubmittingForm = false;

  // To keep the form values
  String? _email;
  String? _username;
  String? _password;

  // setters
  void _setIsEmailAlreadyRegistered(bool value) {
    setState(() {
      _isEmailAlreadyRegistered = value;
    });
  }

  void _setIsUsernameAlreadyTaken(bool value) {
    setState(() {
      _isUsernameAlreadyTaken = value;
    });
  }

  void _setIsSubmittingForm(bool value) {
    setState(() {
      _isSubmittingForm = value;
    });
  }

  void _setIsFormDirty(bool value) {
    setState(() {
      _isFormDirty = value;
    });
  }

  void _setEmail(String? value) {
    setState(() {
      _email = value;
    });
  }

  void _setUsername(String? value) {
    setState(() {
      _username = value;
    });
  }

  void _setPassword(String? value) {
    setState(() {
      _password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above
    return Form(
      key: _formKey,
      autovalidateMode: _isFormDirty
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here
          EmailField(
            isEmailAlreadyRegistered: _isEmailAlreadyRegistered,
            setValue: _setEmail,
            setIsEmailAlreadyRegistered: _setIsEmailAlreadyRegistered,
          ),
          UsernameField(
            isUsernameAlreadyTaken: _isUsernameAlreadyTaken,
            setValue: _setUsername,
            setIsUsernameAlreadyTaken: _setIsUsernameAlreadyTaken,
          ),
          PasswordField(setValue: _setPassword),
          ConfirmPasswordField(password: _password),
          const SizedBox(height: 32),
          SignUpSubmitButton(
            isSubmittingForm: _isSubmittingForm,
            validateForm: () => _formKey.currentState!.validate(),
            saveForm: () => _formKey.currentState!.save(),
            signUp: () => widget.userRepository.signUp(
              _username!,
              _email!,
              _password!,
            ),
            onSignUpSuccess: widget.onSignUpSuccess,
            setIsSubmittingForm: _setIsSubmittingForm,
            setIsUsernameAlreadyTaken: _setIsUsernameAlreadyTaken,
            setIsEmailAlreadyRegistered: _setIsEmailAlreadyRegistered,
            setIsFormDirty: _setIsFormDirty,
            hasAsyncErrors: _hasAsyncErrors,
            getUsername: () => _username,
            showSnackbar: widget.showSnackbar,
          ),
        ],
      ),
    );
  }
}
