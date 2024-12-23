import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/utils/constants/dimens.dart';
import 'package:tasky/utils/widgets/expanded_primary_button.dart';

import '../../../utils/widgets/outlined_form_field.dart';

class SigninForm extends StatefulWidget {
  final TextEditingController usernameTextEditingController;
  final TextEditingController passwordTextEditingController;

  const SigninForm({
    super.key,
    required this.usernameTextEditingController,
    required this.passwordTextEditingController,
  });

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
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
          const ExpandedPrimaryButton("Sign in"),
          SizedBox(height: Dimens.spacing.small),
          Text.rich(
              textAlign: TextAlign.center,
              TextSpan(text: "First time using taskyy? ", children: [
                TextSpan(
                    text: "Get started",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.pushNamed("signup");
                      },
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline)),
                const TextSpan(text: " with taskyy "),
              ])),
        ],
      ),
    );
  }
}
