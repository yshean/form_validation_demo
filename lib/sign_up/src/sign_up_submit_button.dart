// ignore_for_file: public_member_api_docs

import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_validation_simple/ui_elements/expanded_elevated_button.dart';

class SignUpSubmitButton extends StatelessWidget {
  const SignUpSubmitButton({
    required this.isSubmittingForm,
    required this.validateForm,
    required this.saveForm,
    required this.signUp,
    required this.onSignUpSuccess,
    required this.setIsSubmittingForm,
    required this.setIsUsernameAlreadyTaken,
    required this.setIsEmailAlreadyRegistered,
    required this.setIsFormDirty,
    required this.hasAsyncErrors,
    required this.getUsername,
    required this.showSnackbar,
    super.key,
  });

  final bool isSubmittingForm;
  final bool Function() validateForm;
  final void Function() saveForm;
  final Future<void> Function() signUp;
  final void Function(String) onSignUpSuccess;
  final ValueSetter<bool> setIsSubmittingForm;
  final ValueSetter<bool> setIsUsernameAlreadyTaken;
  final ValueSetter<bool> setIsEmailAlreadyRegistered;
  final ValueSetter<bool> setIsFormDirty;
  final bool hasAsyncErrors;
  final String? Function() getUsername;
  final void Function(String) showSnackbar;

  @override
  Widget build(BuildContext context) {
    return isSubmittingForm
        ? ExpandedElevatedButton.inProgress(
            label: 'Sign up',
          )
        : ExpandedElevatedButton(
            icon: const Icon(Icons.login),
            label: 'Sign up',
            onTap: () async {
              setIsFormDirty(true);
              FocusManager.instance.primaryFocus?.unfocus();
              // Validate returns true if form is valid, or false otherwise.
              if (validateForm() && !hasAsyncErrors) {
                try {
                  // If the form is valid, display a loading indicator
                  setIsSubmittingForm(true);
                  // This would help to keep saved form values always valid
                  saveForm();
                  // submit form and sign up
                  await signUp();
                  onSignUpSuccess(getUsername()!);
                } catch (error) {
                  if (error is UsernameAlreadyTakenException) {
                    setIsUsernameAlreadyTaken(true);
                  } else if (error is EmailAlreadyRegisteredException) {
                    setIsEmailAlreadyRegistered(true);
                  } else {
                    showSnackbar(
                        'Something went wrong. Please try again later.');
                  }
                } finally {
                  setIsSubmittingForm(false);
                }
              }
            },
          );
  }
}
