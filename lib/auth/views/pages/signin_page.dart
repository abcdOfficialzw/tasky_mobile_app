import 'package:flutter/material.dart';
import 'package:tasky/auth/views/widgets/signin_form.dart';
import 'package:tasky/utils/constants/dimens.dart';

import '../../../utils/widgets/outlined_form_field.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController usernameTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(Dimens.padding.medium),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign in",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                "Use your username and password to sign in",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: Dimens.spacing.veryLarge,
              ),
              SigninForm(
                usernameTextEditingController: usernameTextEditingController,
                passwordTextEditingController: passwordTextEditingController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
