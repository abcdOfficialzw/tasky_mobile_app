import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasky/services/secure_storage.dart';
import 'package:tasky/sync_service/models/repo/impl/sync_repository_impl.dart';
import 'package:tasky/sync_service/state/bloc.dart';
import 'package:tasky/sync_service/state/network/state.dart';

import '../../models/repo/impl/connectivity_helper.dart';
import '../event.dart';
import 'event.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc._() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  static final NetworkBloc _instance = NetworkBloc._();

  factory NetworkBloc() => _instance;

  void _observe(event, emit) {
    emit(NetworkLoading());
    // show a notification at top of screen.

    ConnectivityHelper.observeNetwork();
  }

  void _notifyStatus(NetworkNotify event, emit) async {
    if (event.isConnected) {
      try {
        SecureStorage secureStorage = SecureStorage();
        DateTime lastSynced = await secureStorage.getLastSynced();

        emit(NetworkSuccess(
          lastSynced:
              "${DateFormat("HH:mm").format(lastSynced)} ${lastSynced.day} ${DateFormat.MMM().format(lastSynced)}",
        ));
      } catch (e) {
        emit(NetworkFailure());
      }
    } else {
      emit(NetworkFailure());
    }
  }
}
