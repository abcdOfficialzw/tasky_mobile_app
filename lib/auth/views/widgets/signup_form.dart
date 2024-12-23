import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants/dimens.dart';
import '../../../utils/widgets/expanded_primary_button.dart';
import '../../../utils/widgets/outlined_form_field.dart';

class SignupForm extends StatefulWidget {
  final TextEditingController usernameTextEditingController;
  final TextEditingController passwordTextEditingController;
  final TextEditingController fullNameTextEditingController;
  const SignupForm(
      {super.key,
      required this.usernameTextEditingController,
      required this.passwordTextEditingController,
      required this.fullNameTextEditingController});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          //Username
          OutlinedFormField(
            label: "Username",
            hintText: "Enter your username",
            textEditingController: widget.usernameTextEditingController,
            autofillHints: const [AutofillHints.username, AutofillHints.email],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          SizedBox(height: Dimens.spacing.large),

          //Full Name
          OutlinedFormField(
            label: "Fullname",
            hintText: "Enter your fullname",
            textEditingController: widget.fullNameTextEditingController,
            autofillHints: const [
              AutofillHints.familyName,
              AutofillHints.email
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your fullname';
              }
              return null;
            },
          ),
          SizedBox(height: Dimens.spacing.large),
          OutlinedFormField(
              label: "Password",
              hintText: "Enter your password",
              textEditingController: widget.passwordTextEditingController,
              autofillHints: const [AutofillHints.password],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              obscureText: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                child: Icon(
                    showPassword ? Icons.visibility_off : Icons.visibility),
              )),
          SizedBox(height: Dimens.spacing.large),
          const ExpandedPrimaryButton("Sign up"),
          SizedBox(height: Dimens.spacing.small),
          Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                  text:
                      "Your data will be stored and processed in accordance with our ",
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                  children: [
                    TextSpan(
                        text: "Terms of Service",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline)),
                    const TextSpan(text: " and "),
                    TextSpan(
                        text: "Privacy Policy",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline)),
                  ])),
        ],
      ),
    );
  }
}
