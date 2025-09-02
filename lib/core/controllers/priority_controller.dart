import 'package:flutter_bloc/flutter_bloc.dart';

class PriorityState {
  final bool highPriority;

  PriorityState({this.highPriority = false});
}

abstract class PriorityEvent {}

class ChangePriority extends PriorityEvent {
  final bool newPriority;

  ChangePriority(this.newPriority);
}

class PriorityController extends Bloc<PriorityEvent, PriorityState> {
  PriorityController() : super(PriorityState()) {
    on<ChangePriority>((event, emit) {
      emit(PriorityState(highPriority: event.newPriority));
    });
  }
}
