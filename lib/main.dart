import 'package:cron/cron.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasky/auth/state/bloc.dart';
import 'package:tasky/routes.dart';
import 'package:tasky/services/secure_storage.dart';
import 'package:tasky/sync_service/models/repo/impl/sync_repository_impl.dart';
import 'package:tasky/sync_service/state/bloc.dart';
import 'package:tasky/sync_service/state/event.dart';
import 'package:tasky/sync_service/state/network/bloc.dart';
import 'package:tasky/sync_service/state/network/event.dart';

import 'app/home_page/state/nav/nav_bloc.dart';
import 'local_db/sql_lite_database_helper.dart';
import 'sync_service/state/network/state.dart';
import 'utils/theme/color_schemes.dart';
import 'utils/theme/type.dart';
import 'package:logging/logging.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';

Future<void> main() async {
  /// Config logging
  /// Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    if (kDebugMode) {
      print(
          '${record.loggerName.toUpperCase()} ${record.level.name}: ${record.time.hour}:${record.time.minute} => ${record.message}');
    }
  });
  WidgetsFlutterBinding.ensureInitialized();
  //await SQLiteDatabaseHelper.instance.initDb('taskyy.db');

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
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
          BlocProvider(
            create: (context) => NetworkBloc()..add(NetworkObserve()),
          ),
          BlocProvider(
            create: (context) => SyncBloc(),
          ),
        ],
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
        ));
  }
}
