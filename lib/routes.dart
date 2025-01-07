import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:tasky/app/home_page/views/pages/home_page.dart';
import 'package:tasky/auth/views/pages/signin_page.dart';
import 'package:tasky/auth/views/pages/signup_page.dart';
import 'package:tasky/landing_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/landing-page',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: [],
    ),
    GoRoute(
      path: '/landing-page',
      name: 'landing-page',
      builder: (BuildContext context, GoRouterState state) {
        return const LandingPage();
      },
      routes: [
        GoRoute(
          path: '/signin',
          name: 'signin',
          builder: (BuildContext context, GoRouterState state) {
            return const SigninPage();
          },
        ),
        GoRoute(
          path: '/signup',
          name: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignupPage();
          },
        )
      ],
    ),
  ],
);
