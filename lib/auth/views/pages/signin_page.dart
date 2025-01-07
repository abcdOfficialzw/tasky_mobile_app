import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/auth/state/bloc.dart';
import 'package:tasky/auth/state/state.dart';
import 'package:tasky/auth/views/widgets/signin_form.dart';
import 'package:tasky/utils/constants/dimens.dart';

import '../../../utils/widgets/outlined_form_field.dart';
import '../../state/event.dart';

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
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    /// alert user
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(state.error)));
                  }
                  if (state is Authenticated) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                            "Welcome ${state.userProfileResponseModel.fullName} 👋🏽")));
                    context.go("/");
                  }
                },
                child: SigninForm(
                  usernameTextEditingController: usernameTextEditingController,
                  passwordTextEditingController: passwordTextEditingController,
                  onSignIn: () {
                    context.read<AuthBloc>().add(
                          SignInEvent(
                            username: usernameTextEditingController.text,
                            password: passwordTextEditingController.text,
                          ),
                        );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
