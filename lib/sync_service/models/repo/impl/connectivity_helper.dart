import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tasky/sync_service/models/repo/impl/sync_repository_impl.dart';

import '../../../state/network/bloc.dart';
import '../../../state/network/event.dart';

class ConnectivityHelper {
  static void observeNetwork() {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      if (result.contains(ConnectivityResult.none)) {
        NetworkBloc().add(NetworkNotify());
      } else {
        NetworkBloc().add(NetworkNotify(isConnected: true));
      }
    });
  }
}
