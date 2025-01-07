abstract class NetworkState {}

class NetworkInitial extends NetworkState {}

class NetworkSuccess extends NetworkState {
  final String lastSynced;

  NetworkSuccess({required this.lastSynced});

  @override
  List<Object?> get props => [lastSynced];
}

class NetworkFailure extends NetworkState {}

class NetworkLoading extends NetworkState {}
