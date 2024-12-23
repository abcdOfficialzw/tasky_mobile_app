import 'package:flutter/material.dart';

import '../../../utils/constants/dimens.dart';
import '../widgets/signup_form.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController usernameTextEditingController =
      TextEditingController();
  final TextEditingController fullnameTextEditingController =
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Sign up",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                "Enter your details to sign up",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: Dimens.spacing.veryLarge,
              ),
              SignupForm(
                usernameTextEditingController: usernameTextEditingController,
                passwordTextEditingController: passwordTextEditingController,
                fullNameTextEditingController: fullnameTextEditingController,
              )
            ]),
          ),
        ));
  }
}
