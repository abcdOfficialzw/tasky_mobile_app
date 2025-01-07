import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/app/tasks/views/pages/tasks_page.dart';
import 'package:tasky/sync_service/state/bloc.dart';
import 'package:tasky/sync_service/state/state.dart';
import 'package:tasky/utils/constants/dimens.dart';

import '../../../../sync_service/state/network/bloc.dart';
import '../../../../sync_service/state/network/state.dart';
import '../../state/nav/nav_bloc.dart';
import '../widgets/bottom_nav.dart';
import '../../../tasks/views/widgets/add_tasks/add_tasks_fab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            if (state is NetworkFailure) {
              return Text(
                "No Internet Connection",
                style: Theme.of(context).textTheme.bodySmall,
              );
            }
            if (state is NetworkLoading) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Connecting...",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(width: Dimens.spacing.small),
                  const CircularProgressIndicator.adaptive(),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
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
      bottomNavigationBar: const BottomNav(),
    );
  }
}
