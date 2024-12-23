part of 'nav_bloc.dart';

class NavigationState extends Equatable {
  final int selectedNavItem;

  const NavigationState({required this.selectedNavItem});

  @override
  List<Object> get props => [selectedNavItem];
}
