part of 'nav_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateTo extends NavigationEvent {
  final int selectedNavItem;

  const NavigateTo({required this.selectedNavItem});

  @override
  List<Object> get props => [selectedNavItem];
}
