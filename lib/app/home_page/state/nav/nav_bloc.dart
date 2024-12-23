import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(selectedNavItem: 0)) {
    on<NavigateTo>((event, emit) {
      emit(NavigationState(selectedNavItem: event.selectedNavItem));
    });
  }
}
