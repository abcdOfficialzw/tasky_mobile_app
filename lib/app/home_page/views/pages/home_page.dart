import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/app/tasks/views/pages/tasks_page.dart';
import 'package:tasky/utils/constants/dimens.dart';

import '../../state/nav/nav_bloc.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, navState) {
          switch (navState.selectedNavItem) {
            case 0:
              return const TasksPage();
            case 1:
              return Container();
            case 2:
              return Container();
            default:
              return Container();
          }
        },
      ),
      floatingActionButton: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return state.selectedNavItem == 0
              ? const FAB()
              : const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
