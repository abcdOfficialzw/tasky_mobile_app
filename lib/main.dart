import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/routes.dart';

import 'app/home_page/state/nav/nav_bloc.dart';
import 'utils/theme/color_schemes.dart';
import 'utils/theme/type.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Taskyy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            textTheme: materialTextTheme()),
        darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            textTheme: materialTextTheme()),
        themeMode: ThemeMode.system,
        routerConfig: router,
      ),
    );
  }
}
