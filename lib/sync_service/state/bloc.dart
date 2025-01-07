// sync_bloc.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import '../models/repo/impl/sync_repository_impl.dart';
import 'event.dart';
import 'state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  SyncBloc() : super(SyncIdle()) {
    on<SyncTasks>(_onSyncTasks);
  }

  Future<void> _onSyncTasks(SyncTasks event, Emitter<SyncState> emit) async {
    emit(SyncInProgress());
    try {
      SyncRepositoryImpl syncRepository = SyncRepositoryImpl();
      syncRepository.addNewTasksToRemote();
      syncRepository.syncDeletedTasks();
      emit(SyncComplete());
    } catch (e) {
      emit(SyncError(error: e.toString()));
    }
  }
}
