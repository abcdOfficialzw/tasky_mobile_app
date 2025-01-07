// sync_state.dart
import 'package:equatable/equatable.dart';

abstract class SyncState extends Equatable {
  const SyncState();

  @override
  List<Object?> get props => [];
}

class SyncIdle extends SyncState {}

class SyncInProgress extends SyncState {}

class SyncComplete extends SyncState {}

class SyncError extends SyncState {
  final String error;

  const SyncError({required this.error});

  @override
  List<Object?> get props => [error];
}
